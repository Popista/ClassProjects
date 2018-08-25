//
// File:        ix_indexhandle.cc
// Description: IX_IndexHandle handles manipulations within the index
// Author:      <Your Name Here>
//

#include <unistd.h>
#include <sys/types.h>
#include <fstream>
#include "ix.h"
#include "pf.h"
#include "comparators.h"
#include <cstdio>
#include <math.h>
#include <ix.h>
#include <parser_internal.h>
#include "rm_internal.h"
using namespace std;

IX_IndexHandle::IX_IndexHandle()
{
  // Implement this

}

IX_IndexHandle::~IX_IndexHandle()
{
  // Implement this
}

int IX_IndexHandle::getData(ifstream &fin, Node &n, int page, int slot){
    int addr;
    addr = (page-1) * header.slotperpage + (slot-1);
    fin.seekg(header.headerSize + addr * header.slotSize, ios_base::beg);
    fin.read((char*)&n, header.slotSize);
    return 0;
}

int IX_IndexHandle::setData(fstream &fout, Node n){
    //fstream fout("a", ios::in|ios::out|ios::binary);  remember close;
    int addr;
    addr = (n.thisNode.pageNum-1) * header.slotperpage + (n.thisNode.slotNum-1);
    fout.seekp(header.headerSize + addr * header.slotSize,ios_base::beg);
    fout.write((char*)&n, header.slotSize);
    return 0;
}

int IX_IndexHandle::modifyHeader(){
    header.totalslot++;
    if((header.totalslot % header.slotperpage > 0) && (header.totalslot / header.slotperpage > header.totalpage - 1)){
        header.totalpage++;
    }
    fstream fout(filename, ios::in|ios::out|ios::binary);
    fout.write((char*)&header, header.headerSize);
    fout.close();
    return 0;
}

int IX_IndexHandle::getNewSlot(int &page, int &slot){
    int temp;
    modifyHeader();
    page = header.totalpage;
    slot = header.totalslot % header.slotperpage;
    return 0;

}

int IX_IndexHandle::addNewNode(fstream &fout, Node &n){  //set isUsed = 1;
    int page, slot;
    getNewSlot(page,slot);
    n.thisNode.slotNum = slot;
    n.thisNode.pageNum = page;
    setData(fout,n);
    n.isUsed = 1;
    return 0;

}
//R-tree operation....
int DelEntry(Entry &e){
    e.isUsed = 0;
    return 0;
}

int initNode(Node &n){
    for(int i=0;i<MAXENTRY;i++){
        n.ey[i].isUsed = 0;
        n.ey[i].bbox.bottom_right_y = 0;
        n.ey[i].bbox.bottom_right_x = 0;
        n.ey[i].bbox.top_left_y = 0;
        n.ey[i].bbox.top_left_x = 0;
        n.nextNode[i].slotNum = 0;
        n.nextNode[i].pageNum = 0;
    }
    n.lastNode.pageNum = 0;
    n.lastNode.slotNum = 0;
    n.thisNode.slotNum = 0;
    n.thisNode.pageNum = 0;
    n.isRoot = 0;
    n.isLeafNode = 0;
    n.entryNum = 0;
    n.isUsed = 0;
    n.isLeaf = RID();
    return 0;
}

int calarea(MBRS e){
    int area;
    area = (e.top_left_y-e.bottom_right_y) * (e.bottom_right_y-e.bottom_right_x);
    return area;
}

MBRS buildbbox(MBRS m1, MBRS m2){
    MBRS a;
    if(m1.top_left_x<m2.top_left_x)
        a.top_left_x = m1.top_left_x;
    else
        a.top_left_x = m2.top_left_x;
    if(m1.top_left_y<m2.top_left_y)
        a.top_left_y = m2.top_left_y;
    else
        a.top_left_y = m1.top_left_y;
    if(m1.bottom_right_x<m2.bottom_right_x)
        a.bottom_right_x = m2.bottom_right_x;
    else
        a.bottom_right_x = m1.bottom_right_x;
    if(m1.bottom_right_y<m2.bottom_right_y)
        a.bottom_right_y = m1.bottom_right_y;
    else
        a.bottom_right_y = m2.bottom_right_y;
    return a;
}

MBRS calNodeBbox(Node n){
    MBRS m, m1[2];
    int mark = 0;
    if(n.entryNum == 1)
        for(int i=0;i<MAXENTRY;i++){
            cout << "yiyhiyi\n";
            if(n.ey[i].isUsed==1){
                return n.ey[i].bbox;
            }
        }
    if(n.entryNum >= 2){ //////

        for(int i=0;i<MAXENTRY;i++){
            if (n.ey[i].isUsed == 1) {
                cout << "uyayaya\n";
                if (mark < 2) {
                    m1[mark++] = n.ey[i].bbox;

                }
                if (mark == 2) {
                    m = buildbbox(m1[0], m1[1]);
                    mark++;
                    continue;
                }
                if (mark > 2) {
                    m = buildbbox(m, n.ey[i].bbox);
                }
            }
        }
    }
    cout << "[" << m.top_left_x << "," << m.top_left_y << "," << m.bottom_right_x
         << "," << m.bottom_right_y << "]" << endl;
    return m;
}


int copyLastEntry(Node &n1, Node &n2){
    n2.nextNode[n2.entryNum] = n1.nextNode[n1.entryNum-1];
    n2.ey[n2.entryNum].bbox = n1.ey[n1.entryNum-1].bbox;
    n2.ey[n2.entryNum].isUsed = 1;
    n1.ey[n1.entryNum-1].isUsed = 0;

    n2.entryNum++;
    n1.entryNum--;
    n2.bbox = calNodeBbox(n2);
    cout << "ggg1\n";
    n1.bbox = calNodeBbox(n1);
    cout << "ggg2\n";
    return 0;
}

/*int PickSeeds(Node n, int &a[2]){
    MBRS temp;
    int area,area1,area2;
    int d = 0;
    for(int i = 0;i<MAXENTRY;i++){
        for(int j = i+1;j<MAXENTRY;j++) {
            if (n.ey[i].isUsed == 1 && n.ey[j].isUsed == 1) {
                temp = buildbbox(n.ey[i].bbox, n.ey[j].bbox);
                area = calarea(temp);
                area1 = calarea(n.ey[i].bbox);
                area2 = calarea(n.ey[j].bbox);
                area = area - area1 - area2;
                if (area > d) {
                    d = area;
                    a[0] = i;
                    a[1] = j;
                }
            }
        }
    }
    return 0;
}*/

int PickNext(Node n, Node n1, Node n2, int &b){
    int a, area1, area2;
    int d = 0;
    MBRS temp1, temp2;
    for(int i=0;i<MAXENTRY;i++){
        if(n.ey[i].isUsed == 1){
            temp1 = buildbbox(n.ey[i].bbox,n1.bbox);
            area1 = calarea(temp1) - calarea(n1.bbox);
            temp2 = buildbbox(n.ey[i].bbox,n2.bbox);
            area2 = calarea(temp2) - calarea(n2.bbox);
            if(abs(area1-area2) > d){
                d = abs(area1-area2);
                b = i;
                if(area1-area2>0)
                    a = 2;
                else
                    a = 1;
            }
        }

    }
    return a;
}

int IX_IndexHandle::QuadSplit(Node n, Node &n1, Node &n2){
    int a[2];
    //PickSeeds(n,a);
    MBRS temp;
    int area,area1,area2;
    int d = 0;
    for(int i = 0;i<MAXENTRY;i++){
        for(int j = i+1;j<MAXENTRY;j++) {
            if (n.ey[i].isUsed == 1 && n.ey[j].isUsed == 1) {
                temp = buildbbox(n.ey[i].bbox, n.ey[j].bbox);
                area = calarea(temp);
                area1 = calarea(n.ey[i].bbox);
                area2 = calarea(n.ey[j].bbox);
                area = area - area1 - area2;
                if (area > d) {
                    d = area;
                    a[0] = i;
                    a[1] = j;
                }
            }
        }
    }
    int b;
    if(n.isLeafNode==1){
        n1.isLeafNode = 1;
        n2.isLeafNode = 1;
    }
    n1.ey[0].bbox = n.ey[a[0]].bbox;
    n2.ey[0].bbox = n.ey[a[1]].bbox;

    n1.ey[0].isUsed = 1;
    n2.ey[0].isUsed = 1;
    n1.entryNum++;n2.entryNum++;
    n1.nextNode[0] = n.nextNode[a[0]];
    n2.nextNode[0] = n.nextNode[a[1]];
    n1.bbox = calNodeBbox(n1);
    n2.bbox = calNodeBbox(n2);
    cout << "ggggb" <<endl;

    n.entryNum = n.entryNum - 2;

    int i = 1, j = 1;
    while(n.entryNum > 0){
        int a2 = 0;
        area1 = 0, area2 = 0;
        int d2 = -1;
        b = 0;
        MBRS temp1, temp2;
        for(int i=0;i<MAXENTRY;i++){
            if(n.ey[i].isUsed == 1){
                temp1 = buildbbox(n.ey[i].bbox,n1.bbox);
                area1 = calarea(temp1) - calarea(n1.bbox);
                temp2 = buildbbox(n.ey[i].bbox,n2.bbox);
                area2 = calarea(temp2) - calarea(n2.bbox);
                if(abs(area1-area2) > d2){
                    d2 = abs(area1-area2);
                    cout << "d2:" <<d2 << endl;
                    b = i;
                    if(area1-area2>0)
                        a2 = 2;
                    else
                        a2 = 1;
                }
            }

        }
        int result = a2;
        n.entryNum--;
        cout << "b:" << b <<endl;

        if(result == 1){

            n1.nextNode[i] = n.nextNode[b];
            n1.ey[i].bbox = n.ey[b].bbox;
            n1.ey[i].isUsed = 1;
            n1.bbox = calNodeBbox(n1);
            n1.entryNum++;
            i++;
        }
        if(result == 2){
            n2.nextNode[j] = n.nextNode[b];
            n2.ey[i].bbox = n.ey[b].bbox;
            n2.ey[i].isUsed = 1;
            n2.bbox = calNodeBbox(n2);
            n2.entryNum++;
            j++;
        }
        n.ey[b].isUsed = 0;
    }
    if(n1.entryNum < MINENTRY || n2.entryNum < MINENTRY){
        printf("ggg");
        if(n1.entryNum < MINENTRY){
            while(n1.entryNum<MINENTRY){
                copyLastEntry(n2,n1);
            }
            return 0;
        }
        if(n2.entryNum < MINENTRY){
            while(n2.entryNum<MINENTRY){
                copyLastEntry(n1,n2);
            }
        }
    }
    return 0;
}

int IX_IndexHandle::refreshBbox(Node &n){
    Node tempNode;
    fstream fout(filename, ios::in | ios::out | ios::binary);
    while(1){
        if(n.isRoot != 1) {
            cout << "rr not\n";
            n.bbox = calNodeBbox(n);

            setData(fout, n);
            fout.close();
            ifstream f1(filename, ios::binary);
            getData(f1, tempNode, n.lastNode.pageNum, n.lastNode.slotNum);
            f1.close();
            for (int z = 0; z < MAXENTRY; z++) {
                if (tempNode.ey[z].isUsed == 1) {
                    if (tempNode.nextNode[z].slotNum == n.thisNode.slotNum &&
                        tempNode.nextNode[z].pageNum == n.thisNode.pageNum) {
                        tempNode.ey[z].bbox = n.bbox;
                    }
                }
            }
            n = tempNode;
        }

        if(n.isRoot == 1){
            cout  << "rr here\n";
            n.bbox = calNodeBbox(n);
            fout.open(filename, ios::in|ios::out|ios::binary);
            setData(fout, n);
            fout.close();
            break;
        }
    }
    return 0;
}

int IX_IndexHandle::Insert(Node newNode ,const RID &rid){
    ifstream f1(filename, ios::binary);
    Node tempNode;
    getData(f1, tempNode, header.rootNode.pageNum, header.rootNode.slotNum);
    f1.close();
    //cout << "rrro" << tempNode.bbox.top_left_x << endl;
    //cout << "rrro" << tempNode.isLeafNode << endl;
    //return 0;
    int newarea, rc = 0;
    int area, least ,j;
    Node x1;
    MBRS m1;
    cout << "insert function \n";
    while(1){
        cout << "first while\n";
        if(tempNode.isLeafNode == 1) {
            if(tempNode.entryNum == MAXENTRY){
                cout << "h11111111\n";
                Node nt1, nt2;
                initNode(nt1);initNode(nt2);
                int mark = 0;
                if(tempNode.isRoot == 1){
                    cout << "h2222222222\n";
                    fstream fout(filename, ios::in|ios::out|ios::binary);
                    Node nt3;
                    initNode(nt3);
                    QuadSplit(tempNode, nt1, nt2);
                    nt3.isUsed = 1;
                    nt3.entryNum = 2;
                    nt3.thisNode = tempNode.thisNode;
                    nt3.isRoot = 1;
                    nt1.lastNode = tempNode.thisNode;
                    nt2.lastNode = tempNode.thisNode;
                    nt1.bbox = calNodeBbox(nt1);
                    nt2.bbox = calNodeBbox(nt2);
                    addNewNode(fout,nt1);
                    addNewNode(fout,nt2);
                    nt3.nextNode[0] = nt1.thisNode;
                    nt3.nextNode[1] = nt2.thisNode;
                    nt3.ey[0].isUsed = 1;
                    nt3.ey[1].isUsed = 1;
                    area = calarea(buildbbox(nt1.bbox,newNode.bbox));
                    newarea = calarea(buildbbox(nt2.bbox,newNode.bbox));
                    if(area>newarea)
                        for(int z=0;z<MAXENTRY;z++){
                            if(nt2.ey[z].isUsed == 0){
                                nt2.ey[z].isUsed = 1;
                                nt2.ey[z].bbox = newNode.bbox;
                                nt2.bbox = calNodeBbox(nt2);
                                newNode.lastNode = nt2.thisNode;
                                addNewNode(fout, newNode);
                                newNode.isLeaf.page = rid.page;
                                newNode.isLeaf.slot = rid.slot;
                                setData(fout, newNode);
                                nt2.nextNode[z] = newNode.thisNode;
                                nt2.entryNum++;
                                setData(fout, nt2);
                                break;
                            }
                        }
                    else
                        for(int z=0;z<MAXENTRY;z++){
                            if(nt1.ey[z].isUsed == 0){
                                nt1.ey[z].isUsed = 1;
                                nt1.ey[z].bbox = newNode.bbox;
                                nt1.bbox = calNodeBbox(nt1);
                                newNode.lastNode = nt1.thisNode;
                                addNewNode(fout, newNode);
                                newNode.isLeaf.page = rid.page;
                                newNode.isLeaf.slot = rid.slot;
                                setData(fout, newNode);
                                nt1.nextNode[z] = newNode.thisNode;
                                nt1.entryNum++;
                                setData(fout, nt1);
                                break;
                            }
                        }
                    nt3.ey[0].bbox = nt1.bbox;
                    nt3.ey[1].bbox = nt2.bbox;
                    nt3.bbox = calNodeBbox(nt3);
                    setData(fout,nt3);
                    fout.close();
                    return rc;
                }
                while(1){
                    cout << "h33333333333333 \n";
                    int isOldNode = 0;
                    initNode(nt1);initNode(nt2);
                    if(tempNode.isRoot == 1){
                        cout << "h 444444444444\n";
                        fstream fout(filename, ios::in|ios::out|ios::binary);
                        Node nt3;
                        initNode(nt3);
                        QuadSplit(tempNode, nt1, nt2);
                        nt3.isUsed = 1;
                        nt3.entryNum = 2;
                        nt3.thisNode = tempNode.thisNode;
                        nt3.isRoot = 1;
                        nt1.lastNode = tempNode.thisNode;
                        nt2.lastNode = tempNode.thisNode;
                        nt1.bbox = calNodeBbox(nt1);
                        nt2.bbox = calNodeBbox(nt2);
                        addNewNode(fout,nt1);
                        addNewNode(fout,nt2);
                        nt3.nextNode[0] = nt1.thisNode;
                        nt3.nextNode[1] = nt2.thisNode;
                        nt3.ey[0].isUsed = 1;nt3.ey[1].isUsed = 1;
                        area = calarea(buildbbox(nt1.bbox,newNode.bbox));
                        newarea = calarea(buildbbox(nt2.bbox,newNode.bbox));
                        if(newNode.thisNode.slotNum != 0 && newNode.thisNode.pageNum != 0){
                            isOldNode = 1;
                        }
                        if(area>newarea)
                            for(int z=0;z<MAXENTRY;z++){
                                if(nt2.ey[z].isUsed == 0){
                                    nt2.ey[z].isUsed = 1;
                                    nt2.ey[z].bbox = newNode.bbox;
                                    nt2.bbox = calNodeBbox(nt2);
                                    newNode.lastNode = nt2.thisNode;
                                    if(isOldNode)
                                        setData(fout, newNode);
                                    else {
                                        addNewNode(fout, newNode);
                                        newNode.isLeaf.page = rid.page;
                                        newNode.isLeaf.slot = rid.slot;
                                        setData(fout, newNode);
                                    }
                                    nt2.nextNode[z] = newNode.thisNode;
                                    nt2.entryNum++;
                                    setData(fout, nt2);
                                    break;
                                }
                            }
                        else
                            for(int z=0;z<MAXENTRY;z++){
                                if(nt1.ey[z].isUsed == 0){
                                    nt1.ey[z].isUsed = 1;
                                    nt1.ey[z].bbox = newNode.bbox;
                                    nt1.bbox = calNodeBbox(nt1);
                                    newNode.lastNode = nt1.thisNode;
                                    if(isOldNode)
                                        setData(fout, newNode);
                                    else {
                                        addNewNode(fout, newNode);
                                        newNode.isLeaf.page = rid.page;
                                        newNode.isLeaf.slot = rid.slot;
                                        setData(fout, newNode);
                                    }
                                    nt1.nextNode[z] = newNode.thisNode;
                                    nt1.entryNum++;
                                    setData(fout, nt1);
                                    break;
                                }
                            }
                        nt3.ey[0].bbox = nt1.bbox;
                        nt3.ey[1].bbox = nt2.bbox;
                        nt3.bbox = calNodeBbox(nt3);
                        setData(fout,nt3);
                        fout.close();
                        return rc;
                    }
                    else{
                         cout << "h555555555\n";
                        //initNode(nt1);initNode(nt2);
                        QuadSplit(tempNode, nt1, nt2);
                        nt1.lastNode = tempNode.lastNode;
                        nt1.thisNode = tempNode.thisNode;
                        nt1.isUsed = 1;
                        nt1.bbox = calNodeBbox(nt1);
                        nt2.bbox = calNodeBbox(nt2);
                        area = calarea(buildbbox(nt1.bbox,newNode.bbox));
                        newarea = calarea(buildbbox(nt2.bbox,newNode.bbox));
                        fstream fout(filename, ios::in|ios::out|ios::binary);

                        if(newNode.thisNode.slotNum != 0 && newNode.thisNode.pageNum != 0){
                            isOldNode = 1;
                        }
                        addNewNode(fout, nt2);
                        if(area>newarea)
                            for(int z=0;z<MAXENTRY;z++){
                                if(nt2.ey[z].isUsed == 0){
                                    nt2.ey[z].isUsed = 1;
                                    nt2.ey[z].bbox = newNode.bbox;
                                    nt2.bbox = calNodeBbox(nt2);
                                    newNode.lastNode = nt2.thisNode;
                                    if(isOldNode)
                                        setData(fout, newNode);
                                    else {
                                        addNewNode(fout, newNode);
                                        newNode.isLeaf.page = rid.page;
                                        newNode.isLeaf.slot = rid.slot;
                                        setData(fout, newNode);
                                    }
                                    nt2.nextNode[z] = newNode.thisNode;
                                    nt2.entryNum++;
                                    setData(fout, nt2);
                                    break;
                                }
                            }
                        else
                            for(int z=0;z<MAXENTRY;z++){
                                if(nt1.ey[z].isUsed == 0){
                                    nt1.ey[z].isUsed = 1;
                                    nt1.ey[z].bbox = newNode.bbox;
                                    nt1.bbox = calNodeBbox(nt1);
                                    newNode.lastNode = nt1.thisNode;
                                    if(isOldNode)
                                        setData(fout, newNode);
                                    else {
                                        addNewNode(fout, newNode);
                                        newNode.isLeaf.page = rid.page;
                                        newNode.isLeaf.slot = rid.slot;
                                        setData(fout, newNode);
                                    }
                                    nt1.nextNode[z] = newNode.thisNode;
                                    nt1.entryNum++;
                                    //setData(fout,nt1);
                                    break;
                                }
                            }
                        cout << "a11111111111\n";
                        setData(fout, nt1);
                        fout.close();
                        f1.open(filename, ios::binary);
                        getData(f1, tempNode, nt1.lastNode.pageNum, nt1.lastNode.slotNum);
                        f1.close();
                        for(int z=0;z<MAXENTRY;z++){
                            cout << "a222222222222\n";
                            if(tempNode.ey[z].isUsed == 1) {
                                if (tempNode.nextNode[z].slotNum == nt1.thisNode.slotNum &&
                                    tempNode.nextNode[z].pageNum == nt1.thisNode.pageNum) {
                                    cout << "guagua\n";
                                    tempNode.ey[z].bbox = nt1.bbox;
                                    break;
                                }
                            }
                        }
                        cout << "a 999999999999\n";

                        refreshBbox(tempNode);
                    }
                    if(tempNode.entryNum < MAXENTRY){
                        cout << "a333333333333\n";
                        fstream fout(filename, ios::in|ios::out|ios::binary);
                        for(int z=0;z<MAXENTRY;z++){
                            if(tempNode.ey[z].isUsed == 0){
                                tempNode.ey[z].bbox = nt2.bbox;
                                //tempNode.bbox = calNodeBbox(tempNode);
                                tempNode.nextNode[z] = nt2.thisNode;
                                nt2.lastNode = nt1.lastNode;
                                tempNode.entryNum++;
                                tempNode.ey[z].isUsed = 1;
                                setData(fout, nt2);
                                refreshBbox(tempNode);
                                setData(fout,tempNode);
                                break;
                            }
                        }
                        fout.close();
                        return rc;
                    }
                    if(tempNode.entryNum == MAXENTRY){
                        cout << "a444444444444\n";
                        newNode = nt2;
                    }

                }

            }
            else{
                cout << "h 6666666666666\n";
                for(int i=0;i<MAXENTRY;i++) {
                    if (tempNode.ey[i].isUsed == 0) {
                        tempNode.ey[i].isUsed = 1;
                        tempNode.ey[i].bbox = newNode.bbox;
                        tempNode.entryNum++;
                        cout << "enNum" << tempNode.entryNum;
                        fstream fout(filename, ios::in | ios::out | ios::binary);

                        addNewNode(fout, newNode);
                        newNode.isLeaf.page = rid.page;
                        newNode.isLeaf.slot = rid.slot;

                        tempNode.nextNode[i] = newNode.thisNode;
                        newNode.lastNode = tempNode.thisNode;
                        setData(fout, newNode);
                        fout.close();
                        x1 = tempNode;
                        break;
                    }
                }
                if(x1.isRoot != 1) {
                    cout << "h 77777777777\n";
                    while (1) {
                        x1.bbox = calNodeBbox(tempNode);
                        fstream fout(filename, ios::in | ios::out | ios::binary);
                        setData(fout, x1);
                        fout.close();
                        f1.open(filename, ios::binary);
                        getData(f1, tempNode, x1.lastNode.pageNum, x1.lastNode.slotNum);
                        f1.close();
                        for (int z = 0; z < MAXENTRY; z++) {
                            if(tempNode.ey[z].isUsed == 1) {
                                if (tempNode.nextNode[z].slotNum == x1.thisNode.slotNum &&
                                    tempNode.nextNode[z].pageNum == x1.thisNode.pageNum) {
                                    tempNode.ey[z].bbox = x1.bbox;
                                    break;
                                }
                            }
                        }
                        x1 = tempNode;
                        if (x1.isRoot == 1) {
                            x1.bbox = calNodeBbox(tempNode);
                            fstream fout(filename, ios::in | ios::out | ios::binary);
                            setData(fout, x1);
                            fout.close();
                            return rc;
                        }
                    }
                }
                else{
                    Node gd;
                    tempNode.bbox = calNodeBbox(tempNode);
                    fstream fout(filename, ios::in | ios::out | ios::binary);
                    setData(fout, tempNode);
                    fout.close();
                    return rc;
                }



            }

            break;
        }
        else{
            cout << "h 9999999999999\n";
            newarea = calarea(newNode.bbox);
            least = 10000;
            j = 0;
            for(int i=0;i<MAXENTRY;i++){
                if(tempNode.ey[i].isUsed == 1) {
                    area = calarea(tempNode.ey[i].bbox);
                    m1 = buildbbox(newNode.bbox, tempNode.ey[i].bbox);
                    area = calarea(m1) - area;
                    if (area < least) {
                        least = area;
                        j = i;
                    }
                }
            }
            x1 = tempNode;
            f1.open(filename, ios::binary);
            getData(f1, tempNode, x1.nextNode[j].pageNum, x1.nextNode[j].slotNum);
            f1.close();
        }

    }
    return 0;

}

RC IX_IndexHandle::InsertEntry(void *pData, const RID &rid)
{
  // Implement this
    //add new Data
    char *s;
    const char *sep = ","; //split by ","
    char *p;
    int b[4];
    int i = 0;
    s = (char*)pData;
    char temp[MAXSTRINGLEN];
    sprintf(temp,"%s",s);  //temp is used to split the string
    p = strtok(temp, sep); //using strtok to split
    while(p){
        b[i] = atoi(p);  //transform char into int
        cout << b[i] <<"\n";
        i++;
        if(i>4){
            break;
        }
        p = strtok(NULL, sep);
    }

    printf("insert\n");
    cout<<this->filename;
    ifstream f1(this->filename, ios::binary);
    f1.read((char*)&(this->header), sizeof(Ixheader));
    f1.close();


    Node newNode;
    initNode(newNode);
    newNode.bbox.ctemp = s;
    newNode.bbox.top_left_x = b[0];
    newNode.bbox.top_left_y = b[1];
    newNode.bbox.bottom_right_x = b[2];
    newNode.bbox.bottom_right_y = b[3];
    //cout << newNode.bbox.bottom_right_x;

    //newNode.isLeaf = rid;            ///

    Insert(newNode , rid);
    RC rc;
    rc = 0;
    return (rc);
}

int isOverlap(MBRS m1, MBRS m2){
    if(m1.top_left_x<m2.bottom_right_x && m1.top_left_y > m2.bottom_right_y &&
       m1.bottom_right_y < m2.top_left_y && m1.bottom_right_x > m2.top_left_x)
        return 1;
    return 0;

}

int IX_IndexHandle::treeSearch(Node n, MBRS value, const RID &rid){
    if(n.isLeafNode == 1){
        int mark = 0;
        for(int i=0;i<MAXENTRY;i++){
            if(n.ey[i].isUsed == 1) {
                if (isOverlap(value, n.ey[i].bbox)) {
                    n.entryNum--;

                    n.nextNode[i].slotNum = 0;
                    n.nextNode[i].pageNum = 0;
                    n.ey[i].isUsed = 0;
                    n.bbox = calNodeBbox(n);

                    fstream fout(filename, ios::in | ios::out | ios::binary);
                    setData(fout, n);
                    fout.close();
                    mark = 1;
                }
            }


        }
        if(mark == 1){
            tmNod[tmn++] = n;
        }
        return 0;
    }
    else {
        for (int i = 0; i < MAXENTRY; i++) {
            if(n.ey[i].isUsed == 1) {
                if (isOverlap(value, n.ey[i].bbox)) {
                    Node m;
                    ifstream fin(filename, ios::binary);
                    getData(fin, m, n.nextNode[i].pageNum, n.nextNode[i].slotNum);
                    fin.close();
                    treeSearch(m, value, rid);
                }
            }
        }
    }
    return 0;
}


int IX_IndexHandle::CondenseTree(Node n, const RID &rid){
    Node x1 = n;
    if(x1.isRoot == 1){
        return 0;
    }
    while(x1.isRoot != 1){
        if(x1.entryNum < MINENTRY){
            Node m;initNode(m);
            ifstream fin(filename, ios::binary);
            getData(fin, m, x1.lastNode.pageNum, x1.lastNode.slotNum);
            fin.close();
            for (int z = 0; z < MAXENTRY; z++) {
                if(m.ey[z].isUsed == 1) {
                    if (m.nextNode[z].slotNum == x1.thisNode.slotNum &&
                        m.nextNode[z].pageNum == x1.thisNode.pageNum) {
                        m.ey[z].isUsed = 0;
                        refreshBbox(m);

                        break;
                    }
                }
            }
            for(int i=0;i<MAXENTRY;i++){
                if(n.ey[i].isUsed == 1){
                    Node xx;
                    fin.open(filename, ios::binary);
                    getData(fin, xx, n.nextNode[i].pageNum, n.nextNode[i].slotNum);
                    fin.close();
                    Insert(xx ,rid);
                }
            }
            x1 = m;
        }
        if(x1.entryNum >= MINENTRY || x1.isRoot == 1){
            return 0;
        }
    }
    return 0;

}

RC IX_IndexHandle::DeleteEntry(void *pData, const RID &rid)
{
  // Implement this
    ifstream f1(filename, ios::binary);
    f1.read((char*)&header, sizeof(Ixheader));
    f1.close();
    MBRS temp = *(MBRS *)pData;
    f1.open(filename, ios::binary);
    Node tempNode;
    getData(f1, tempNode, header.rootNode.pageNum, header.rootNode.slotNum);
    f1.close();
    treeSearch(tempNode, temp, rid);
    for(int i=0;i<tmn;i++) {
        CondenseTree(tmNod[i], rid);
    }
    RC rc = 0;
    return rc;
}


RC IX_IndexHandle::ForcePages() {
    // only proceed if this filehandle is associated with an open file
    RC rc = 0;
    return rc;
}
