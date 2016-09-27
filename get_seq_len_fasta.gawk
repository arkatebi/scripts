#!/bin/awk -f
# This script calculates lenght of each sequence in a
# fasta file.
# How to run this script:
# gawk -f seq_len_dist.gawk sample.fa

BEGIN {
    n=0 # stores the number of sequences
    len=0 # stores the length of a fasta sequence
}
{
    if (substr($0,1,1)==">"){ # check for fasta sequence marker
       n++
       protName[n]=substr($1,2,length($1)) # save the protein name
       if (n>1){ # save the length before re-initializing the length variable
          protLen[protName[n-1]]=len
       }
       len=0 # re-initialize length variable for the next sequence
    }
    else { # continuation of the same sequence to the next line
      len=len+length($0)
    }
}

END {
   protLen[protName[n]]=len
   for (i=1;i<=n;++i){
       printf("%s\t%d\n",protName[i], protLen[protName[i]])
   }
}