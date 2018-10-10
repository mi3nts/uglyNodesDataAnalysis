#!/usr/bin/python3

# uglyNodes(Waggle)dataOrganizer
# author: Lakitha Wijeratne
# date: October 6th 2018

import csv
import sys, getopt
import time
import argparse
import os
def main(argv):
    parser = argparse.ArgumentParser(description='Manipulate csv dataset')
    parser.add_argument('-i', '--input', dest='input', help='Input file path')
    parser.add_argument('-o', '--output', dest='output', help='Output file path')
    parser.add_argument('-n', '--nodeID', dest='nodeID', help='Node ID')

    args = parser.parse_args()

    if args.input is None:
        print('[ ERROR ] No input is specified.')
        parser.print_help()
        exit(1)

    if not os.path.exists(args.input):
        print('[ ERROR ] Input file path is invalid.')
        exit(1)
    else:
        inputPath = args.input
    print("Input Path: "+inputPath)

    if args.output is None:
        print('[WARNING] Output file is not specified.')
        print('[ INFO  ] Output will be output.csv')
        outputPath = './output.csv'
    else:
        outputPath = args.output
    print("outputPath: "+outputPath)

    if args.nodeID is None:
        print('[ ERROR ] nodeID not specified.')
        parser.print_help()
        exit(1)
    else:
        nodeID = args.nodeID
    print("nodeID: "+nodeID)
    [reader,keys] = getListDictionary(inputPath,nodeID)
    writeCSV(reader,outputPath,keys)



def getListDictionary(inputPath,nodeID):
    reader = csv.DictReader(open(inputPath))
    reader = list(reader)
    reader = [v for v in reader if v['node_id'] == nodeID]
    keys = ['timestamp','node_id','subsystem','sensor','parameter','value_raw','value_hrf']
    return reader,keys;

def writeCSV(reader,outputPath,keys):
    with open(outputPath,'w') as output_file:
        writer = csv.DictWriter(output_file, fieldnames=keys)
        writer.writeheader()
        writer.writerows(reader)


if __name__ == "__main__":
   main(sys.argv[1:])
