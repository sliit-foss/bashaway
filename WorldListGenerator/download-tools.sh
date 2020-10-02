#!/bin/bash

export GOPATH=$HOME/go
#hakrawler
go get github.com/hakluke/hakrawler
sudo cp ~/go/bin/hakrawler /usr/bin/


#httpx
go get -u -v github.com/projectdiscovery/httpx/cmd/httpx
sudo cp ~/go/bin/httpx /usr/bin

#unfurl
go get -u github.com/tomnomnom/unfurl
sudo cp ~/go/bin/unfurl /usr/bin



#fff
go get -u github.com/tomnomnom/fff
sudo cp ~/go/bin/fff /usr/bin


#gau
go get -u -v github.com/lc/gau
sudo cp ~/go/bin/gau /usr/bin

#waybackurls
go get github.com/tomnomnom/waybackurls
sudo cp ~/go/bin/waybackurls /usr/bin

#tok
wget https://raw.githubusercontent.com/tomnomnom/hacks/master/tok/main.go
go build main.go
mv main tok
sudo cp tok /usr/bin
sudo cp tok ~/go/bin


