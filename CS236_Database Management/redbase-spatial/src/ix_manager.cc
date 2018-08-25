//
// File:        ix_indexmanager.cc
// Description: IX_IndexHandle handles indexes
// Author:      Yifei Huang (yifei@stanford.edu)
//
#include <cstdio>
#include <iostream>
#include <fstream>
#include <unistd.h>
#include <sys/types.h>
#include "ix.h"
#include "pf.h"
#include <climits>
#include <string>
#include <sstream>
#include <cstdio>
#include <ix.h>
#include "comparators.h"
#include "rm_internal.h"
using namespace std;

IX_Manager::IX_Manager(PF_Manager &pfm) : pfm(pfm){
}

IX_Manager::~IX_Manager()
{

}

/*
 * Creates a new index given the filename, the index number, attribute type and length.
 */
RC IX_Manager::CreateIndex(const char *fileName, int indexNo,
                   AttrType attrType, int attrLength)
{
    RC rc = 0;
    if(fileName == NULL)
        return (RM_BADFILENAME);


    string a;
    a = fileName;
    a = a + to_string(indexNo);
    //DestroyIndex(fileName,indexNo);
    fstream fout("./../" + a, ios::out|ios::binary);


    Ixheader newHeader;
    newHeader.rootNode.pageNum = 1;
    newHeader.rootNode.slotNum = 1;
    newHeader.headerSize = sizeof(Ixheader);
    newHeader.slotperpage = 4;
    newHeader.totalpage = 1;
    newHeader.totalslot = 1;
    newHeader.slotSize = sizeof(Node);
    Node firstRoot;
    firstRoot.isRoot = 1;
    firstRoot.isUsed = 1;
    firstRoot.isLeafNode = 1;
    firstRoot.entryNum = 0;
    for(int i=0;i<MAXENTRY;i++){
        firstRoot.ey[i].isUsed = 0;
        firstRoot.ey[i].bbox.bottom_right_y = 0;
        firstRoot.ey[i].bbox.bottom_right_x = 0;
        firstRoot.ey[i].bbox.top_left_y = 0;
        firstRoot.ey[i].bbox.top_left_x = 0;
    }
    firstRoot.thisNode.pageNum = 1;
    firstRoot.thisNode.slotNum = 1;
    fout.write((char*)&newHeader,newHeader.headerSize);
    fout.seekp(newHeader.headerSize,ios_base::beg);
    fout.write((char*)&firstRoot,newHeader.slotSize);

    fout.close();



    return(rc);
}

/*
 * This function destroys a valid index given the file name and index number.
 */
RC IX_Manager::DestroyIndex(const char *fileName, int indexNo)
{
    printf("111\n");
    RC rc = 0;
    string a;
    a = fileName;
    a = "./../" + a + to_string(indexNo);
    const char *temp;
    temp = a.c_str();
    printf("%s\n",temp);
    if((rc = pfm.DestroyFile(temp)))
        return (rc);
    return (0);
}

/*
 * This function, given a valid fileName and index Number, opens up the
 * index associated with it, and returns it via the indexHandle variable
 */
RC IX_Manager::OpenIndex(const char *fileName, int indexNo,
                 IX_IndexHandle &indexHandle)
{
    string a;
    a = fileName;
    a = a + to_string(indexNo);

    RC rc;
    // Open the file
    ifstream fin("./../"+a, ios::binary);
    indexHandle.filename = "./../"+a;
    fin.read((char*)&(indexHandle.header),sizeof(Ixheader));
    rc = 0;
    //cout << 222;
    fin.close();
    return (rc);
}

/*
 * Given a valid index handle, closes the file associated with it
 */
RC IX_Manager::CloseIndex(IX_IndexHandle &indexHandle)
{
    RC rc = 0;
    return rc;
}
