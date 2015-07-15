
__author__ = 'greg'


# This is a python tool for filtering out the KEGG Genes 
# from the count files 

##############
# Modules
##############

import argparse as argp
from csv import reader
from csv import writer 
import subprocess as sub

###############
# Functions
###############

def get_KEGG_List():
	'''
	This function gets the list of LEGG
	Prostate cancer genes from the file 
	I created.
	'''
	f = reader(open('KEGG_Prostate_Cancer_Genes','rb'),delimiter='\n')
	kegg_genes = []
	for i in f:
		kegg_genes.append(i)
	kegg_genes_2 = []
	for i in kegg_genes:
		kegg_genes_2.append(i[0])
	return kegg_genes_2

def get_all_files(path_to_condition):
	'''
	This function gets the list of all count files 
	in a particular directory.  
	'''
	file_list = sub.check_output(['ls',path_to_condition]).split('\n')
	files = []
	for i in file_list:
		if i != '':
			files.append(i)
	return files 


def count_file_list(path_to_condition,count_file):
	'''
	This function turn the count file in to a 
	list object to be filtered in the filter
	count file function.
	'''
	f = reader(open(path_to_condition+count_file,'rb'),delimiter='\t')
	count_list = []
	for i in f:
		count_list.append(i)
	count_list = count_list[1:]
	return count_list

def filter_count_file(kegg_genes,count_list):
	'''
	filters the count_list to remove any
	kegg_genes present
	'''
	filtered_list = []
	for i in count_list:
		if i[0] not in kegg_genes:
			filtered_list.append(i)
	return filtered_list

def create_filtered_counts_file(filtered_list,count_file,output_directory,
	path_to_condition):
	'''
	This writes the filtered list to a tab delimited 
	txt file similar to the original htseq-count file. 
	'''
	sub.call(['mkdir',path_to_condition+output_directory])
	with open(path_to_condition+output_directory+'/'+count_file,'wb') as f:
		write = writer(f,delimiter='\t')
		write.writerows(filtered_list)
		f.close()
	return


def main(path_to_condition,output_directory):
	kegg_genes = get_KEGG_List()
	files = get_all_files(path_to_condition)
	for i in files:
		count_list = count_file_list(path_to_condition,i)
		filtered_list = filter_count_file(kegg_genes,count_list)
		create_filtered_counts_file(filtered_list,i,output_directory,
			path_to_condition)
	return


#######################

if __name__ == '__main__':
	parser = argp.ArgumentParser()
	parser.add_argument('-c','--con',help="Path to condition count files to be filtered"
		"must end with /")
	parser.add_argument('-o','--out',help="The name of the output directory" 
		"where you want the filtered count files")
	arg = parser.parse_args()
	main(arg.con,arg.out)
