
__author__ = 'Greg Hamilton'
'''
Tools for pulling the percentage of
uniquely aligned reads from STAR
log.out files and moving them into 
a tab delimited file to be easily used by R.  
'''

# Pull the log % into a file for analysis
# first create a list of the files to pull from
# Create a list from  reading all the files for the
# line with uniquely mapped reads.
# Write the new list to a single file with the
# one column as sample names(from the file list)
# and the second column being the % Uni Mapped Reads

#################
# Modules 
#################

from csv import writer
import subprocess as sub
import argparse

#################
# Functions
#################

def file_names(path_to_directory):
    '''
    Pulls a list of the files from a particular directory.
    :param path_to_directory: The path from current directory
    to the directory with the files of interest
    :return: A list of the files of interest.
    '''
    files_list = sub.check_output(['ls',path_to_directory])
    files_list = files_list.split('\n')
    files_list_2 = []
    for i in files_list:
        if "Log.final.out" in i:
            files_list_2.append(i)
    return files_list_2

def pull_percentages(path_to_input,file_list):
    '''
    This function creates a list of of lists.
    Each with 2 elements, the file name and the
    align percentage.
    :param file_list: A list of STAR Log.final.out files
     to pull the percentages from.
    :return: A list of lists with the percentages and sample names.
    '''
    full_list = []
    for x in file_list:
        f = open(path_to_input+x)
        for i,line in enumerate(f):
            if i == 9:
                full_list.append([x.replace('Log.final.out',''),line.split('|\t')[1].strip().replace('%','')])
    return full_list

def write_file(full_list,file_name,path_to_output):
    '''
    Writes the list to a tab delimited file to easily be read by R.
    :param full_list: The list of lists each with 2 elements
    [Sample,Uniquely mapped read %]
    :param file_name: The name you'd like for the output file.
    :param path_to_output: the path to the directory you'd like to store the
    output file.
    :return: A .csv file that is tab delimited build from the input list
    '''
    if path_to_output == '':
        with open(file_name +'.csv','wb') as f:
            write = writer(f,delimiter='\t')
            write.writerows(full_list)
            f.close()
    else:
         with open(path_to_output + file_name +'.csv','wb') as f:
            write = writer(f,delimiter='\t')
            write.writerows(full_list)
            f.close()
    return

def main(path_to_input,file_name,path_to_output):
    file_list = file_names(path_to_input)
    percent_list = pull_percentages(path_to_input,file_list)
    write_file(percent_list,file_name,path_to_output)
    return


##################
##################

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-p","--inputpath",help="Path to input file directory",default='')
    parser.add_argument("-o",'--outputpath',help='Path to output directory',default = '')
    parser.add_argument("-f",'--filename',help='Name of the output filename',default='')
    args = parser.parse_args()
    main(args.inputpath,args.filename,args.outputpath)
