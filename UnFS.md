### Introduction ###
UnFS is a node based filesystem that uses variable size pointers to memory locations and disk blocks to manage files.
### Warning ###
This filesystem will change so do not ignore the version number! Also, when the first stable build is made, the version number will be set to 1 instead of the current 0. It is best to ignore filesystems that use a version number that is 0 or negative as I will be using these values to indicate versions in between the stable version.
### Table of Contents ###
  1. #### [Header](UnFS#Header_Structure.md) ####
  1. #### [Node Collection](UnFS#Node_Collection_Structure.md) ####
  1. #### [Node](UnFS#Node_Structure.md) ####
  1. #### [Sector List](UnFS#Sector_List_Structure.md) ####
  1. #### [Index](UnFS#Index_Structure.md) ####
### Header Structure ###
The header contains information about the filesystem that is extremely important.
| **Size** | **Default** | **Meaning** |
|:---------|:------------|:------------|
| 1 | 4 | This is the length of the filesystem's signature |
| 4 | "UnFS" | This is the signature of the filesystem |
| 2 | 1 | This is the version of the filesystem |
| 1 | 6 | This is the size of the block pointers in bytes |
| 1 | 4 | This is the size of the memory pointers in bytes |
| 1 | 2 | This is the size of user and group ID's in bytes |
| 1 | 9 | This is the size of the allocation cluster in bytes as an exponent of 2 |
| 1 | 0 | This is the character encoding used by the filesystem |
| 4 | N/A | This is a pointer to the root node collection's sector list |
| 4 | N/A | This is a pointer to the index's sector list |

### Node Collection Structure ###
A node collection holds the nodes of the children of a certain node.
| **Size** | **Meaning** |
|:---------|:------------|
| 4 | Location of the end of the node collection as an offset from the root node collection. |
| N/A | Various nodes. See below. |
| 4 | 0 if this is the last portion of the node collection and an offset from the root node collection pointing to the next portion if it is not. |

### Node Structure ###
A node holds information about files and folders. It points to the sector list, index information, security information, its parent's node, and has a type that denotes wether it is a file, folder, link, device, etc.
| **Size** | **Meaning** |
|:---------|:------------|
| 4 | Location of the index entry as an offset in the index |
| 1 | Type. 0 is a folder, 1 is a file, more will be added |
| 4 | Location of the security information. 0 gives everyone full access.|
| 4 | Location of the node collection as an offset from the root node collection for folders or sector list for files. |
| 4 | Location of parent node as an offset from root node collection. 0 means no parent. |

### Sector List Structure ###
The sector list holds block numbers pointing to a file's actual data.
| **Size** | **Meaning** |
|:---------|:------------|
| 4 | The offset of the end of the list in the root node collection |
| 6 | The LBA of the first sector in a fragment. |
| 6 | The LBA of the last sector in a fragment. |
| N/A | There can be more paired LBAs here. |
| 4 | 0 if this is the last fragment. It points to the next fragment if it is not.|

### Index Structure ###
The index will hold useful and searchable metadata pertaining to the file such as modification and creation times and the file name.
| **Size** | **Meaning** |
|:---------|:------------|
| 4 | This is a pointer back to the file's or folder's node as an offset in the root node collection. |
| N/A | This is the name of the file or folder as a zero terminated string. |