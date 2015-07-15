

### Python Script I made for running STAR on multiple fastq files
# Capture_file_Names is a function for pulling the list of SRA files
#
# run_STAR is a function for massing running STAR
# 	-It loops through the list of fastq file generated by capture_file_names
#    - I had to manual change index and the depending on which study was being run as 
#   - They had varying read lengths. 

##########################
# Modules
##########################
import subprocess
import argparse as argp
##########################
# Functions
##########################


def capture_file_names(SRA_name):
	file_list = subprocess.check_output(['ls','../SRAs/'+ SRA_name + '/fastq/'])
	file_list = file_list.split('\n')
	SRAs = []
	#print '1'
	for i in file_list:
		if i != '':
			i = i.replace('_1.fastq','')
			i = i.replace('_2.fastq','')
			if i not in SRAs:
				SRAs.append(i)
	#print '2'
	return SRAs

#print 'f2'

def run_STAR(names,SRA_name):
	for i in names:
		subprocess.call(['STAR','--outFileNamePrefix ../SRAs/STAR/'+SRA_name+'/'+i,'--runThreadN 20','--outSAMtype BAM Unsorted','--genomeDir ../SRAs/Star_index_49','--readFilesIn','../SRAs/'+SRA_name+'/fastq/'+i+'_1.fastq','../SRAs/'+SRA_name+'/fastq/'+i+'_2.fastq'])
	#print '5'
	return

#print 'f5'

###############################
###############################

if __name__ == '__main__':
	parser = argp.ArgumentParser()
	parser.add_argument('SRA')
	arg = parser.parse_args()
	SRA_name = arg.SRA
	SRAs = capture_file_names(SRA_name)
	#print SRAs
	#print folders
	run_SRA(SRAs,SRA_name)
