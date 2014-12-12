#Process the Data
#David Clancy

import sys
import os
	


def readLines(file,path):
	lines = []
	pathway = [path,"/",file]
	filename = "".join(pathway)
	f = open(filename)
	for line in f.readlines():
		line = line.strip()
		lines.append(line)
	f.close()
	return lines
	
	
def combineRawData(signals,subjects,activities):
	newData = []
	counter = 0
	for i in range(len(subjects)):
		for j in range(64):
			thisLine = []
			for source in signals:
				#print counter
				thisLine.append(source[counter])
			counter+=1
			thisLine.append(subjects[i])
			thisLine.append(activities[i])
			newData.append(thisLine)
	return newData

def deleteRepetition(signals):
	noRepeats = []
	for source in signals:
		thisSource = []
		for line in source:
			line = line.split()
			for i in range(64):
				thisSource.append(line[i])
				#print line[i]
		noRepeats.append(thisSource)
	return noRepeats
	
def writeData(filename,lines,files):
	f = open(filename,'w')
	f.write(','.join(files))
	f.write(',subject,activity\n')
	for line in lines:
		f.write(','.join(line))
		f.write("\n")
	f.close()
	



def processData():
	path = sys.argv[1]
	files = os.listdir(path)
	print len(files)
	signals = []
	for file in files:
		signals.append(readLines(file,path))
	signals = deleteRepetition(signals)
	for source in signals:
		print len(source)
	subjects = readLines("subject_train.txt","UCI_HAR_Dataset/train")
	print len(subjects)
	activities = readLines("y_train.txt","UCI_HAR_Dataset/train")
	print len(activities)
	newLines = combineRawData(signals,subjects,activities)
	writeData(sys.argv[2],newLines,files)
	
	


if __name__ == '__main__':
  processData()
