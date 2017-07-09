import sys


_, tmpl, content, subst = sys.argv

with open(content, 'r') as content_f:
    content_s = content_f.read()

with open(tmpl, 'r') as tmpl_f:
    s = ""
    for l in tmpl_f.readlines():
        s += l.replace(subst, content_s)
        
    print(s)
    
