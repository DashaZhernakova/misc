#!/usr/bin/python
import sys
import argparse

def searchInAllCols(spl, v, set):
	if not v:
		for elem in spl:
			if elem in set:
				return True
		return False
	else:
		for elem in spl:
			if elem in set:
				return False
		return True

def parseArguments():
	parser = argparse.ArgumentParser(description="Searches strings from one file in another file", add_help=True, epilog = "Finished",conflict_handler="resolve")
	parser.add_argument('-i', type = str, help = "Path to file where the search is performed", required = True, dest = 'i_fname')
	parser.add_argument('-f', type = str, help = "Path to file from which the query strings are taken", required = True, dest = 'f_fname')
	parser.add_argument('--i_col', '-i_col', type = int, help = "Column in the -i file to search in", required = True, dest = 'i_col')
	parser.add_argument('--f_col', '-f_col', type = int, help = "Column in the -f file to take the queries to search for", required = True, dest = 'f_col')
	parser.add_argument('--header', action = "store_true", default = False, help = "Consider the first line in the -i file as a header and add it to the output", dest = 'header')
	parser.add_argument('-d','-sep', type = str, help = "Field separator", default = "\t", dest = 'sep')
	parser.add_argument('-i_d','--i_sep', '-i_sep', type = str, help = "Field separator for the -i file", dest = 'i_sep')
	parser.add_argument('-f_d', '--f_sep', '-f_sep', type = str, help = "Field separator for the -f file", dest = 'f_sep')
	parser.add_argument('--i_all', '-i_all', action = "store_true", default = "False", help = "Search in all columns of the -i file", dest = 'i_all')
	parser.add_argument('-v', action = "store_true", help = "Reverse the search: output if line not in -f file", default = False, dest = 'v')
	parser.add_argument('--f_add', '-f_add', action = "store_true", help = "Add the query line from the -f file to the output (-v option is ignored)", default = False, dest = 'f_add')
	
	args = parser.parse_args()
	sys.stderr.write(vars(args)['sep'] + "\n\n")
	#if args.sep != None:
	#	args.sep = args.sep.decode('string-escape')
	if args.i_sep != None:
		args.i_sep = args.i_sep.decode('string-escape')
	else:
		args.i_sep = args.sep
	if args.f_sep != None:
		args.f_sep = args.f_sep.decode('string-escape')
	else:
		args.f_sep = args.sep
	
	for arg, val in vars(args).items():
		sys.stderr.write(arg + "\t" + str(val) + "\n")
	return args

def main(args):

	
	sep = args['sep']
	v = args['v']
	f_col = args['f_col']
	i_col = args['i_col']
	query_set = set()
	
	with open(args['f_fname']) as f_file:
		for line in f_file:
			spl = line.strip().split(args['f_sep'])
			query_set.add(spl[f_col])
			
	
	if len(query_set) == 0:
		sys.stderr.write("Empty -f file!!!")
	
	with open(args['i_fname']) as i_file:
		if args['header']:
			print i_file.readline().strip()
		for line in i_file:
			spl = line.strip().split(args['i_sep'])
			
			if not args['i_all']:
				if ((not v) and (spl[i_col] in query_set)) or ((v) and (spl[i_col] not in query_set)):
					print line.strip()
			else:
				if searchInAllCols(spl, v, query_set):
					print line.strip()

def vlookup(args):
	sep = args['sep']
	v = False
	f_col = args['f_col']
	i_col = args['i_col']
	query_dict = {}
	with open(args['f_fname']) as f_file:
		for line in f_file:
			spl = line.strip().split(args['f_sep'])
			query_dict[spl[f_col]] = line.strip()
	if len(query_dict) == 0:
		sys.stderr.write("Empty -f file!!!")
	
	with open(args['i_fname']) as i_file:
		if args['header']:
			print i_file.readline().strip()
		for line in i_file:
			spl = line.strip().split(args['i_sep'])
			if not args['i_all']:
				if spl[i_col] in query_dict.keys():
					print line.strip() + sep + query_dict[spl[i_col]]
			else:
				if searchInAllCols(spl, v, query_dict):
					print line.strip() + sep + query_dict[spl[i_col]]
				
if __name__ == "__main__":
	args = vars(parseArguments())
	
	if not args['f_add']:
		main(args)
	else:
		vlookup(args)
