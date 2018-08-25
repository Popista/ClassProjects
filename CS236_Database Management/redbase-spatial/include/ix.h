//
// ix.h
//
//   Index Manager Component Interface
//

#ifndef IX_H
#define IX_H

#include <cstdio>
#include <iostream>
#include "redbase.h"  // Please don't change these lines
#include "rm_rid.h"  // Please don't change these lines
#include "pf.h"
#include <string>
#include <cstdlib>
#include <cstring>
#include "parser_internal.h"
#define MAXENTRY 6
#define MINENTRY 2
using namespace std;
//
// IX_IndexHandle: IX Index File interface
//


typedef struct{
    int pageNum;
    int slotNum;
} location;

typedef struct{
    int totalpage;                      // number of pages
    int totalslot;
    int slotperpage;                   // calculated max # of recs per page
    int headerSize;
    int slotSize;
    location rootNode;
} Ixheader;

typedef struct{
    MBRS bbox;
    int isUsed;
} Entry;


typedef struct{
    int isRoot;
    RID isLeaf;
    int entryNum;
    int isLeafNode;
    int isUsed;
    MBRS bbox;
    location thisNode;
    location lastNode;
    location nextNode[MAXENTRY];
    Entry ey[MAXENTRY];
} Node;


class IX_IndexHandle {
public:
    friend class IX_Manager;
    friend class IX_IndexScan;
    IX_IndexHandle();
    ~IX_IndexHandle();
    // Insert a new index entry
    RC InsertEntry(void *pData, const RID &rid);

    // Delete a new index entry
    RC DeleteEntry(void *pData, const RID &rid);

    // Force index files to disk
    RC ForcePages();

    int CondenseTree(Node n, const RID &rid );
    int treeSearch(Node n, MBRS value, const RID &rid);
    int Insert(Node newNode, const RID &rid);
    int refreshBbox(Node &n);
    int addNewNode(fstream &fout, Node &n);
    int getNewSlot(int &page, int &slot);
    int modifyHeader();
    int setData(fstream &fout, Node n);
    int getData(ifstream &fin, Node &n, int page, int slot);
    int QuadSplit(Node n, Node &n1, Node &n2);
    Ixheader header;
    string filename;
    // returns true if this FH is associated with an open file
private:

    Node tmNod[20];
    int tmn = 0;

};

//
// IX_IndexScan: condition-based scan of index entries
//
class IX_IndexScan {
public:
    IX_IndexScan();
    ~IX_IndexScan();

    // Open index scan
    RC OpenScan(const IX_IndexHandle &indexHandle,
                CompOp compOp,
                void *value,
                ClientHint  pinHint = NO_HINT);


    // Get the next matching entry return IX_EOF if no more matching
    // entries.
    RC GetNextEntry(RID &rid);
    MBRS value;
    RID result[100];
    int mark = 0;
    int ix = 0;
    int sh = 0;
    Ixheader header;
    string filename;

    int treeSearch(Node n);
    int addNewNode(fstream &fout, Node &n);
    int getNewSlot(int &page, int &slot);
    int modifyHeader();
    int setData(fstream &fout, Node n);
    int getData(ifstream &fin, Node &n, int page, int slot);
    int isOverlap(MBRS m1, MBRS m2);
    // Close index scan
    RC CloseScan();
};

//
// IX_Manager: provides IX index file management
//
class IX_Manager {
public:
    IX_Manager(PF_Manager &pfm);
    ~IX_Manager();

    // Create a new Index
    RC CreateIndex(const char *fileName, int indexNo,
                   AttrType attrType, int attrLength);

    // Destroy and Index
    RC DestroyIndex(const char *fileName, int indexNo);

    // Open an Index
    RC OpenIndex(const char *fileName, int indexNo,
                 IX_IndexHandle &indexHandle);

    // Close an Index
    RC CloseIndex(IX_IndexHandle &indexHandle);
    RC SetUpFH(IX_IndexHandle& fileHandle, PF_FileHandle &fh, struct IX_FileHeader* header);

private:
    PF_Manager &pfm; // reference to program's PF_Manager111
    RC CleanUpFH(IX_IndexHandle &fileHandle);

};

//
// Print-error function
//
void IX_PrintError(RC rc);

#define IX_BADINDEXSPEC         (START_IX_WARN + 0) // Bad Specification for Index File
#define IX_BADINDEXNAME         (START_IX_WARN + 1) // Bad index name
#define IX_INVALIDINDEXHANDLE   (START_IX_WARN + 2) // FileHandle used is invalid
#define IX_INVALIDINDEXFILE     (START_IX_WARN + 3) // Bad index file
#define IX_NODEFULL             (START_IX_WARN + 4) // A node in the file is full
#define IX_BADFILENAME          (START_IX_WARN + 5) // Bad file name
#define IX_INVALIDBUCKET        (START_IX_WARN + 6) // Bucket trying to access is invalid
#define IX_DUPLICATEENTRY       (START_IX_WARN + 7) // Trying to enter a duplicate entry
#define IX_INVALIDSCAN          (START_IX_WARN + 8) // Invalid IX_Indexscsan
#define IX_INVALIDENTRY         (START_IX_WARN + 9) // Entry not in the index
#define IX_EOF                  (START_IX_WARN + 10)// End of index file
#define IX_LASTWARN             IX_EOF

#define IX_ERROR                (START_IX_ERR - 0) // error
#define IX_LASTERROR            IX_ERROR

#endif
