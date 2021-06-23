import sys
import os
import csv

def cleanFile(file,output_file):
    if os.path.exists(file):
        if os.stat(file).st_size != 0:
            with open(file,"r+") as f:
                readCSV = csv.reader(f,delimiter='\t')
                with open(output_file, 'w') as result:
                    writer = csv.writer(result, delimiter="\t")
                    for row in readCSV:
                        del row[1:6]
                        writer.writerow(row)
        else:
            raise Exception("El fichero se encuentra vacío")
    else:
        raise Exception("El fichero no existe") 

if __name__ == '__main__':

    cleanFile(sys.argv[1], sys.argv[2])
