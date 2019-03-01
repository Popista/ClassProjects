//
// File:        ix_indexscan.cc
// Description: IX_IndexHandle handles scanning through the index for a 
//              certain value.
// Author:      <Your name here>
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

IX_IndexScan::IX_IndexScan()
{
  // Implement this
}

IX_IndexScan::~IX_IndexScan()
{
  // Implement this
}

int IX_IndexScan::getData(ifstream &fin, Node &n, int page, int slot){
    int addr;
    addr = (page-1) * header.slotperpage + (slot-1);
    fin.seekg(header.headerSize + addr * header.slotSize, ios_base::beg);
    fin.read((char*)&n, header.slotSize);
    return 0;
}

int IX_IndexScan::setData(fstream &fout, Node n){
    //fstream fout("a", ios::in|ios::out|ios::binary);  remember close;
    int addr;
    addr = (n.thisNode.pageNum-1) * header.slotperpage + (n.thisNode.slotNum-1);
    fout.seekp(header.headerSize + addr * header.slotSize,ios_base::beg);
    fout.write((char*)&n, header.slotSize);
    return 0;
}

int IX_IndexScan::modifyHeader(){
    header.totalslot++;
    if((header.totalslot % header.slotperpage > 0) && (header.totalslot / header.slotperpage > header.totalpage - 1)){
        header.totalpage++;
    }
    fstream fout(filename, ios::in|ios::out|ios::binary);
    fout.write((char*)&header, header.headerSize);
    fout.close();
    return 0;
}

int IX_IndexScan::getNewSlot(int &page, int &slot){
    int temp;
    modifyHeader();
    page = header.totalpage;
    slot = header.totalslot % header.slotperpage;
    return 0;

}

int IX_IndexScan::addNewNode(fstream &fout, Node &n){  //set isUsed = 1;
    int page, slot;
    getNewSlot(page,slot);
    n.thisNode.slotNum = slot;
    n.thisNode.pageNum = page;
    setData(fout,n);
    n.isUsed = 1;
    return 0;

}

RC IX_IndexScan::OpenScan(const IX_IndexHandle &indexHandle,
                CompOp compOp,
                void *value,
                ClientHint  pinHint)
{
  // Impleme
    RC rc = 0;
    this->header = indexHandle.header;
    this->filename = indexHandle.filename;
    MBRS ttm = *(MBRS*)value;

    this->value = ttm;
    return rc;
}

int IX_IndexScan::isOverlap(MBRS m1, MBRS m2){
    if(m1.top_left_x<m2.bottom_right_x && m1.top_left_y > m2.bottom_right_y &&
            m1.bottom_right_y < m2.top_left_y && m1.bottom_right_x > m2.top_left_x)
        return 1;
    return 0;

}

int IX_IndexScan::treeSearch(Node n){  //recursive
    if(n.isLeafNode == 1){
        //cout << "3313123hahah" << n.bbox.top_left_x << endl;
        for(int i=0;i<MAXENTRY;i++){

            if(n.ey[i].isUsed == 1) {

                if (isOverlap(this->value, n.ey[i].bbox)) {
                    //cout << "3313123hahah" << n.bbox.top_left_x << endl;
                    Node m;
                    ifstream fin(filename, ios::binary);
                    getData(fin, m, n.nextNode[i].pageNum, n.nextNode[i].slotNum);
                    fin.close();
                    result[mark].slot = m.isLeaf.slot;
                    result[mark++].page = m.isLeaf.page;
                    cout << "[" << m.bbox.top_left_x << "," << m.bbox.top_left_y << "," << m.bbox.bottom_right_x
                         << "," << m.bbox.bottom_right_y << "]" << endl;
                }
            }
        }
        return 0;
    }
    else {
        for (int i = 0; i < MAXENTRY; i++) {
            if(n.ey[i].isUsed == 1) {
                if (isOverlap(this->value, n.ey[i].bbox)) {
                    Node m;
                    ifstream fin(filename, ios::binary);
                    getData(fin, m, n.nextNode[i].pageNum, n.nextNode[i].slotNum);
                    fin.close();
                    treeSearch(m);
                }
            }
        }
    }
    //cout << "mark :    " << mark << endl;
    return 0;
}

RC IX_IndexScan::GetNextEntry(RID &rid)
{
  // Implemenet this




    RC rc;
    rc = 0;

    if(mark != 0 && ix < mark) {
        //cout << "ix :    " << ix << endl;
        //cout << "mark :    " << mark << endl;

        //rid = result[ix];
        //cout << "valid RID::" <<rid.slot <<endl;
        ix++;

        return rc;
    }
    else{
        //cout << "mark :    " << mark << endl;
        if(ix != 0 && mark != 0 && ix == mark){
            cout << "ix :    " << ix << endl;
            rc = 1;
            return rc;
        }
        ifstream fin(filename, ios::binary);
        fin.read((char *) &header, sizeof(Ixheader));
        fin.close();
        Node tempNode;
        ifstream f1(filename, ios::binary);
        getData(f1, tempNode, header.rootNode.pageNum, header.rootNode.slotNum);
        f1.close();
        treeSearch(tempNode);
        //cout << "3313123hahah" << tempNode.bbox.top_left_x << endl;
        //rid = result[ix];
        //cout << "mark :    " << mark << endl;
    }

    return rc;
}

RC IX_IndexScan::CloseScan()
{
  // Implement this
    RC rc = 0;
    return rc;
}
