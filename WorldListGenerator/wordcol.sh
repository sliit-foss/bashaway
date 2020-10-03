#!/bin/bash


Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Orange='\033[0;33m'       # Orange
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m' # No Color
BB='\e[30;48;5;51m'       #Background Blue
BG='\e[30;48;5;82m'       #Background L1Yellow
BR='\e[30;48;5;196m'      #Background Red
Yellow='\e[38;5;190m'     #Yellow
LYellow='\e[38;5;228m'    #Light Yellow
L1Yellow='\e[38;5;228m'    #Light Yellow


echo  -e ${Yellow}"

          __        __   ___    ____    ____     ____    ___    _     
          \ \      / /  / _ \  |  _ \  |  _ \   / ___|  / _ \  | |    
           \ \ /\ / /  | | | | | |_) | | | | | | |     | | | | | |    
            \ V  V /   | |_| | |  _ <  | |_| | | |___  | |_| | | |___ 
             \_/\_/     \___/  |_| \_\ |____/   \____|  \___/  |_____|
                                                                      
 

                                                             $(echo  "\e[40;38;5;82m By \e[30;48;5;82m Cimihan \e[0m")

"${NC}

Usage(){
        while read -r line; do
                printf "%b\n" "$line"
        done  <<-EOF
\r ${L1Yellow}|- ${NC} ${LYellow} -h/--help\t\t Help 
\r ${L1Yellow}|- ${NC} ${LYellow} -d/--domain\t Domain to extract endpoints
\r ${L1Yellow}|- ${NC} ${LYellow} -dd/--domains\t Give List of  Domains file to extract endpoints
\r ${L1Yellow}|- ${NC} ${LYellow} -f/--file\t\t Give urls file



EOF
 exit 1
}







slasher(){

#checking if starting word is '/' or not
	for i in $(cat endpoint/wordlists.txt);do
	    starting=$(echo $i | awk '{print substr ($0,0,1)}' )
	    if [ $starting = '/' ];then
		    echo $i >> do.txt
	    else
		    echo '/'$i >> do.txt
	    fi

	done

	#checking if ending word is '/' or not

	for i in $(cat do.txt);do
	    end=$(echo $i | awk '{print substr ($0,length,1)}' )
	    if [ $end = '/' ];then
            echo $i | rev | cut -c 2-  |rev   >> endpoint/wordlist.txt
        else
            echo $i >> endpoint/wordlist.txt
	    fi

	done


}




#Gau file or wayback file or hakcrawl or anyother related file for extracting endpoints
urlsFile(){

        echo -e "${Orange} [+] UrlsFile${NC}"
    
    
        cat $file | unfurl -u keys  | tee file.txt >/dev/null
        cat $file | unfurl -u paths | tee -a file.txt >/dev/null
        sed 's#/#\n#g' file.txt  | sort -u | tee -a endpoints.txt    >/dev/null


        mkdir endpoint/ 2>/dev/null
        cat $file | head -n 1000 | fff -s 200 -s 404 -o out >/dev/null
        echo -e "${Orange}[*] Greping${NC}"
        grep -roh "\"\/[a-zA-Z0-9_/?=&]*\"" out/  | sed -e 's/^"//' -e 's/"$//' | sort -u | tee -a endpoints.txt 

        #sorting
    
        cat endpoints.txt | grep -iv '.css$\|.png$\|.jpeg$\|.jpg$\|.svg$\|.gif$\|.woff$\|.woff2$\|.bmp$\|.mp4$\|.mp3$\|.js$'  | tee -a endpoint/wordlists.txt >/dev/null


        rm file.txt
        rm -rdf out/

        echo -e "${Orange}   [+]Done${NC}"

        #slasher function
        slasher

        #soring the file and appending it in wordlists.txt 
        sort -u endpoint/wordlist.txt | tee -a  endpoint/endpoints.txt >/dev/null
        rm do.txt endpoints.txt  endpoint/wordlist.txt endpoint/wordlists.txt


}


Endpoints() {

        echo -e "${Orange}[+] Endpoints - ${L1Yellow}$domain${NC}"
             
        gau $domain | tee -a gau.txt >/dev/null
        cat gau.txt | unfurl -u keys  | tee -a ends.txt   >/dev/null
        cat gau.txt | unfurl -u paths | tee -a ends.txt   >/dev/null
        sed 's#/#\n#g' ends.txt  | sort -u | tee -a wordlist.txt   >/dev/null

        rm ends.txt
         
}


curling() {


        echo -e "${Orange}[+] Curling - ${L1Yellow}$domain${NC}"
      
        echo $domain | httpx -threads 4 -o httpx.txt -silent >/dev/null
        curl https://tools.ietf.org/html/rfc1866 -o rfc.html  -s
        cat httpx.txt | xargs curl -s -L | tee -a curled.html >/dev/null
        cat curled.html | tok | tr '[:upper:]' '[:lower:]' | sort -u | tee -a  curled.txt   >/dev/null
        cat rfc.html | tok | tr '[:upper:]' '[:lower:]' | sort -u |   tee -a rfc.txt   >/dev/null
        comm -13 rfc.txt curled.txt | sort -u | tee -a words.txt >/dev/null
        rm httpx.txt rfc.html rfc.txt curled.txt curled.html

}



jsfiles(){

        echo -e "${Orange}[+] JsFiles - ${L1Yellow}$domain${NC}"
   
        cat gau.txt | head -n 1000 | fff -s 200 -s 404 -o out >/dev/null
        grep -roh "\"\/[a-zA-Z0-9_/?=&]*\"" out/ | sed -e 's/^"//' -e 's/"$//' | sort -u | tee -a words.txt  >/dev/null
       
}


wayback(){


        echo -e "${Orange}[+] WaybackUrls - ${L1Yellow}$domain${NC}"
        
        echo $domain | waybackurls | tee -a way.txt >/dev/null
        cat way.txt | unfurl -u keys| tee -a wayback.txt >/dev/null
        cat way.txt |unfurl -u paths|tee -a wayback.txt >/dev/null
        sed 's#/#\n#g' wayback.txt  |sort -u |tee -a waybacks.txt >/dev/null
        rm wayback.txt  
    }


hakcrawl(){
    
        echo -e "${Orange}[+] Hakcrawling - ${L1Yellow}$domain${NC}"
       
        echo $domain | hakrawler -plain -usewayback -scope yolo | unfurl -u keys  | sort -u | tee -a words.txt >/dev/null
        echo $domain | hakrawler -plain -usewayback -scope yolo | unfurl -u paths | sort -u | tee -a words.txt >/dev/null


} 


Sorting() {


        echo -e "[*] ${Blue} Sorting ${NC} [*]"
        
        mkdir endpoint 2>/dev/null
        cat words.txt wordlist.txt waybacks.txt |  sort -u  |tee -a endpoint/sorted.txt >/dev/null
        cat endpoint/sorted.txt | grep -iv '.css$\|.png$\|.jpeg$\|.jpg$\|.svg$\|.gif$\|.woff$\|.woff2$\|.bmp$\|.mp4$\|.mp3$\|.js$'  | tee -a endpoint/wordlists.txt >/dev/null

        rm words.txt  wordlist.txt waybacks.txt endpoint/sorted.txt

        #slasher function
        slasher

        rm endpoint/wordlists.txt
        cat endpoint/wordlist.txt |  sort -u | tee  -a endpoint/endpoints.txt >/dev/null
        rm endpoint/wordlist.txt do.txt


        echo -e "[*] ${Red} Sorted ${NC} [*]"
        echo -e "\n"
}

bold=$(tput bold)


sigleMain() {


        echo -e  "\t\t\t\t${Red}${BG} A single Domain    ${NC}"
        echo -e " "
      
        cc=$(echo $domain | wc -l)
     
            if [[ $cc -eq "1" ]] && [[ $domain != '' ]];
            then
                #single   
                Endpoints
                hakcrawl
                
                curling
                wayback
                jsfiles

                #sorting
                Sorting          

            else
                echo  -e "\t\t\t\t   ${BB} See the help ${NC}"
                echo -e "\n"
            fi
}


loopMain(){

        echo -e "\t\t\t\t${BG}  For multiple Domains   ${NC}"
        echo -e "\n"

        count=0
        cc=$(cat $domains | wc | awk '{ print $1}')
        while read domain ; do
            if [ $cc -gt 0 ];
            then

                #loop
                echo -e "        ${Blue}[ $count - $domain ] ${NC}"
                hakcrawl
                Endpoints
                curling
                wayback
                jsfiles

                count=$((count+1))
                echo '\n'

                
            else
                echo -e "${Cyan}Invalid or File is Empty"
            fi            
            
        done < $domains

        #sorting
        Sorting
}


while [ -n "$1" ]; do
case "$1" in
        -d|--domain)
                domain=$2
                sigleMain
                shift;;

        -dd|--domains)
                domains=$2
                if [ -z "$2"  ];then
                    echo -e  "\t\t\t\t${Red}${BG}  For Multiple Domains  ${NC}"
                    echo -e " "
                    echo  -e "\t\t\t\t     ${BB} See the help ${NC}"
                    echo -e "\n"
                else
                loopMain

                fi
                shift;;

        -f|--file)
                file=$2
                urlsFile
                shift;;        

        -h|--help)
                help=$2
                Usage
                shift;;

        *)
                echo -e "${Cyan} [-] Unknown Option:${NC}${Yellow}\t$1"
                Usage
                shift;;

        esac
        shift
done


if [ "$domains" = '' ] && [ "$domain" = ''  ] && [ "$file" = ''  ]; then

    	echo -e "${Yellow} Either give only -d/--domain name  or -dd/--domains text file${NC}"
    	Usage

fi


