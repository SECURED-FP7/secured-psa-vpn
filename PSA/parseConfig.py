import json
import sys

def parseJSON(jsonPath, defaultConfigPath, ipsecConfigPath):
	try:
		f = open(jsonPath, 'r')	
		strjson=f.read().replace('\n', '')		
		jsObj = json.loads(str(strjson))
		
		try:
			dc = open(defaultConfigPath)
    			lines = dc.readlines()    			
			r = open(ipsecConfigPath, 'w')
			r.writelines(lines)
			
			default = jsObj["default"]
			if(default):
				r.write("conn %default\n")
				for p in default:
					r.write("\t" + p + "=" + default[p] + "\n")
				r.write("\n")
			psa = jsObj["psa"]	
			if(psa):
				r.write("conn psa\n")
				for p in psa:
						
					if psa[p] != "":
						r.write("\t" + p + "=" + psa[p] + "\n")
					elif p == "left":
						r.write("\t" + p + "=%any" + "\n")
					elif p == "leftsourceip":
						r.write("\t" + p + "=%config" + "\n")
						
			r.write("\n")
			#r.close()
		except Exception,e: 
			print str(e)
			print "Can't open ipsec config file"
	except Exception,e: 
		print str(e)
		print "Can't open json config file"

args = sys.argv
if len(args) == 4:
	parseJSON(args[1],args[2],args[3])
else:
	print "Usage: parseConfig.py [jsonPath] [defaultConfigPath] [ipsecConfigPath]"
