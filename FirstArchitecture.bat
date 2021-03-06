@echo off
cls
color f0
type intro.txt
timeout 1
cls
color 0f
type intro.txt
timeout 1
cls
color 9f
type intro.txt
timeout 1
cls
color f0
type intro.txt
pause 

	
cls
color 0f
echo ________________________________________________________________________________________________________________
echo :::::::::::::::::::::::::::::::::::::   {{* Key Creation *}}   :::::::::::::::::::::::::::::::::::::::::::::
echo ================================================================================================================
echo *** Now I am  creating Key pair with Default name (AccessKey) 
echo ### So, To Create Key,  I used command :
echo .
echo ################################################################################################################
echo ####### COMMAND : 
echo    ----      aws ec2 create-key-pair --key-name AccessKey --query KeyMaterial --output text > AccessKey.pem
echo **************************************************************************************************************

echo ================================================================================================================
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ________________________________________________________________________________________________________________
echo .
echo .
echo @@@  Key Creating : 

"C:\Program Files\Amazon\AWSCLIV2\aws"  ec2 create-key-pair --key-name AccessKey --query KeyMaterial --output text > AccessKey.pem
set accesskey="AccessKey.pem"
set path=".\AccessKey.pem"
C:\Windows\System32\timeout 3
echo ===========================================================================================================
echo ------------------------- Hurrey !!! key Pair Created and Downloaded --------------------------------------
echo ===========================================================================================================
start https://ap-south-1.console.aws.amazon.com/ec2/v2/home?region=ap-south-1#KeyPairs: 
pause
C:\Windows\System32\icacls.exe %path% /reset
C:\Windows\System32\icacls.exe %path% /GRANT:R "kaushal:(R)"
C:\Windows\System32\icacls.exe %path% /inheritance:r
cls









color 0f
echo ________________________________________________________________________________________________________________
echo :::::::::::::::::::::::::::::::::   {{* Security Group Creation *}}   ::::::::::::::::::::::::::::::::::::::::::
echo ================================================================================================================
echo *** Now I am  creating Security Group with Default name (Task 6) and setting ( allow all traffic from anywhere)  
echo ### So, To Create SG,  I used command :
echo .
echo ################################################################################################################
echo ####### COMMAND : 
echo $$$$$$$      aws" ec2 create-security-group --group-name task6 --description "Task 6 aws architecture security 
echo              group" --output text > securitydetail.txt
echo .
echo $$$$$$$      aws ec2 authorize-security-group-ingress  --group-name task6 --cidr 0.0.0.0/0 --protocol all		 
echo **************************************************************************************************************

echo ================================================================================================================
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ________________________________________________________________________________________________________________
echo .
echo .
echo @@@  SG Creating  Soon : 

"C:\Program Files\Amazon\AWSCLIV2\aws" ec2 create-security-group --group-name task6 --description "Task 6 aws architecture security group" --output text > securitydetail.txt
"C:\Program Files\Amazon\AWSCLIV2\aws" ec2 authorize-security-group-ingress  --group-name task6 --cidr 0.0.0.0/0 --protocol all

C:\Windows\System32\timeout 3
set /p SG=<securitydetail.txt
echo ====================================================================================================
echo -------------------------  Security Group Created ----------------------------------------
echo ====================================================================================================
start https://ap-south-1.console.aws.amazon.com/ec2/v2/home?region=ap-south-1#SecurityGroups:
pause
cls







color 0f
echo ________________________________________________________________________________________________________________
echo :::::::::::::::::::::::::::::::::::   {{* Instance  Creation *}}   ::::::::::::::::::::::::::::::::::::::::::::
echo ================================================================================================================
echo *** So now we are creating Ec2 instance with Default name (Default) and  settings as follows :
echo .
echo #####     Default AMI = ami-03cfb5e1fb4fac428 ( Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type )
echo #####     Default Instance Type = t2.micro
echo #####     Default Subnet = subnet-8e2124e6 ( ap-south-1a)
echo #####     Key and SG are above created Key and SG.
echo .

echo ++++++ So, To Create Instance,  I used command :
echo .
echo ################################################################################################################
echo ####### COMMAND : 
echo $$$$$$$      aws ec2 run-instances --image-id ami-0e306788ff2473ccb  --instance-type t2.micro 
echo              --key-name AccessKey --subnet-id subnet-3bb8bd53 --security-group-ids %SG% 
echo              --query Instances[].InstanceId --output text > instanceid.txt
echo **************************************************************************************************************
echo .  
echo ================================================================================================================
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ________________________________________________________________________________________________________________
echo .
echo .
echo @@@  Creating Instance and starting :).........

echo .

"C:\Program Files\Amazon\AWSCLIV2\aws" ec2 run-instances --image-id ami-0e306788ff2473ccb  --instance-type t2.micro --key-name AccessKey --subnet-id subnet-3bb8bd53 --security-group-ids %SG% --query Instances[].InstanceId --output text > instanceid.txt
C:\Windows\System32\timeout 20
start https://ap-south-1.console.aws.amazon.com/ec2/v2/home?region=ap-south-1#Instances:
set /p instanceID=<instanceid.txt
echo ====================================================================================================
echo -------------------------  Instance Created and starting ----------------------------------------
echo ====================================================================================================
pause
echo .
echo .
echo .
"C:\Program Files\Amazon\AWSCLIV2\aws" ec2 describe-instances --instance-ids %instanceID% --query Reservations[-1].Instances[].[PublicIpAddress] --output text > publicIp.txt

set /p instanceIP=<publicIp.txt
echo Instance Description :
echo       ________________________________________________________________________________________
echo       "|                                                                                    |"
echo       "| ######################  *****************************   #########################  |"
echo       "| ######################  *** Instance Brief Detail ***   #########################  |"
echo       "| ######################  *****************************   #########################  |"
echo       "|____________________________________________________________________________________|"
echo       "|                                        |                                           |"
echo       "|                                        |                                           |" 
echo       "|    Instance ID                         |        %instanceID%                                   
echo       "|    -----------                         |                                           |" 
echo       "|                                        |                                           |" 
echo       "|    Instance Public IP                  |        %instanceIP%                       
echo       "|    ------------------                  |                                           |" 
echo       "|  == = ====================================================================         |" 
echo       "|____________________________________________________________________________________|"

echo .
pause








cls
color 0f
echo ________________________________________________________________________________________________________________
echo :::::::::::::::::::::::::::::::::::   {{* EBS Volume Creation *}}   ::::::::::::::::::::::::::::::::::::::::::::
echo ================================================================================================================
echo *** So Now we are creating Ec2 EBS Volume with :
echo .
echo #####     Size = 1 Gib
echo #####     Default Volume Type = gp2
echo .

echo ++++++ So, To Create Volume,  I used command :
echo .
echo ################################################################################################################
echo ####### COMMAND : 
echo $$$$$$$      aws" ec2 create-volume --availability-zone ap-south-1a --size 1 --query VolumeId 
echo              --output text >volumeid.txt
echo **************************************************************************************************************
echo .  
echo ================================================================================================================
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ________________________________________________________________________________________________________________
echo .
echo .
echo @@@  Creating EBS Volume:).........

echo .


"C:\Program Files\Amazon\AWSCLIV2\aws" ec2 create-volume --availability-zone ap-south-1a --size 1 --query VolumeId --output text >volumeid.txt
C:\Windows\System32\timeout 10
echo .
echo .
set /p vol=<volumeid.txt
echo ====================================================================================================
echo --------------  EBS volume Created [ ID : %vol% ]---------------------
echo ====================================================================================================
echo .
echo .
echo @@@  Now EBS Volume wil be attach, so for that.
pause 



echo *
echo *
echo Volume : attaching ...
"C:\Program Files\Amazon\AWSCLIV2\aws" ec2 attach-volume --device /dev/xvdf --instance-id %instanceID% --volume-id file://volumeid.txt
C:\Windows\System32\timeout 5
start https://ap-south-1.console.aws.amazon.com/ec2/v2/home?region=ap-south-1#Volumes:sort=desc:volumeId
echo ====================================================================================================
echo -------------------------  EBS volume Created and Attached ----------------------------------------
echo ====================================================================================================
echo ---------------------------------------------------------------------------------------------------
pause





cls
color 0f


echo ________________________________________________________________________________________________________________
echo ::::::::::::::::::::::::::::   {{* Webserver and Partition Creation *}}   ::::::::::::::::::::::::::::::
echo ================================================================================================================
echo *** So Now we are configuring Web-Server and also creating partition :
echo .
echo .
pause 
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo yum install httpd -y
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo fdisk /dev/xvdf
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo mkfs.ext4 /dev/xvdf1
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo mount /dev/xvdf1 /var/www/html
echo *
echo *
echo *

echo ====================================================================================================
echo -------------------------  Webserver and Partition Created ----------------------------------------
echo ====================================================================================================
pause




cls
color 0f

echo .
echo .
echo ________________________________________________________________________________________________________________
echo :::::::::::::::::::::::::::::::::::   {{* S3 Bucket Creation *}}   ::::::::::::::::::::::::::::::::::::::::::::
echo ================================================================================================================
echo *** So Now we create s3 bucket and Upload our static webdata over s3 bucket. S3 Bucket detail :
echo .
echo #####     Bucket Name : kaushaltestings3
echo #####     NOTE : The Website static data should be in "staticData" directory as folder will upload on s3.
echo .

echo ++++++ So, To Create Volume,  I used command :
echo .
echo ################################################################################################################
echo ####### COMMAND : 
echo $$$$$$$      aws" s3 mb s3://kaushaltestings3 --region ap-south-1
echo $$$$$$$      aws" s3 cp staticData s3://kaushaltestings3/staticData/ --recursive
echo **************************************************************************************************************
echo .  
echo ================================================================================================================
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ________________________________________________________________________________________________________________
echo .
echo .
echo @@@  Creating S3 Bucket :).........
echo .
echo .
"C:\Program Files\Amazon\AWSCLIV2\aws" s3 mb s3://kaushaltestings3 --region ap-south-1
"C:\Program Files\Amazon\AWSCLIV2\aws" s3 cp staticData s3://kaushaltestings3/staticData/ --recursive
C:\Windows\System32\timeout 3
echo .
echo .
echo ====================================================================================================
echo -------------------------  S3 Bucket Created and content uploaded ----------------------------------
echo ====================================================================================================
C:\Windows\System32\timeout 2
start https://s3.console.aws.amazon.com/s3/home?region=ap-south-1#
set s3="https://kaushaltestings3.s3.ap-south-1.amazonaws.com/"
echo @@@@  Link= %s3%  +file_path  ( Like : staticData/me.jpg )
set origin=kaushaltestings3.s3.ap-south-1.amazonaws.com
pause

:s3web
cls
echo .
echo .
"C:\Program Files\Amazon\AWSCLIV2\aws" s3 ls s3://kaushaltestings3 --recursive > s3list.txt
echo .
echo .
echo ====================================================================================================
echo -------------------------  S3 Bucket Content List ----------------------------------
echo ====================================================================================================
echo ***
type s3list.txt
echo ***
pause

echo .
echo .
echo .
echo .
echo ====================================================================================================
echo -------------------------  Website Creation with S3 Link : ----------------------------------
echo ====================================================================================================
echo .
echo ***
echo Now  update website with S3 data links :
echo @@@@  S3 Link= %s3%  +file_path  ( Like : staticData/me.jpg )

C:\Windows\System32\timeout 3
mkdir website 
start website

echo ###  Once you done with website update then 
pause

cls
echo .
echo .
echo .
echo .
echo website hosting ...
C:\Windows\System32\OpenSSH\scp -i %accesskey% -r website ec2-user@%instanceIP%:~
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo cp -rf website /var/www/html/
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo service httpd start
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo systemctl start httpd 
C:\Windows\System32\timeout 5
echo ====================================================================================================
echo -------------------------  Website Hosted and uploaded ----------------------------------
echo ====================================================================================================

echo ###   Access Site  on link : http://%instanceIP%/website/index.html 
start http://%instanceIP%/website/index.html 

pause
:option
set /p choice="Do you want again update website ( y/n ) : "
if %choice% == y goto s3web
if %choice% == n goto cont 
if not %choice% == y goto incorrect1

:incorrect1
echo *** Incorrect Input. Please enter again.
pause
goto option
:cont
cls
:option2
set /p choice2="Do you want Aws CloudFront CDN service also ( y/n ) : "
if %choice2% == y goto cdn
if %choice2% == n goto end
if not %choice2% == y goto incorrect2

:incorrect2
echo *** Incorrect Input. Please enter again.
pause
goto option2

:cdn
cls
color 0f

echo .
echo .
echo ________________________________________________________________________________________________________________
echo :::::::::::::::::::::::::::::::::::   {{* CloudFront CDN Creation *}}   ::::::::::::::::::::::::::::::::::::::::
echo ================================================================================================================
echo *** So Now we create CDN using CloudFront and Upload our static webdata cache for CDN :
echo .
echo #####     Origin : %origin%
echo #####     NOTE : CloudFront origin is our S3 bucket.
echo .

echo ++++++ So, To Create CDN,  I used command :
echo .
echo ################################################################################################################
echo ####### COMMAND : 
echo $$$$$$$      aws" s3 mb s3://kaushaltestings3 --region ap-south-1
echo $$$$$$$      aws" s3 cp staticData s3://kaushaltestings3/staticData/ --recursive
echo **************************************************************************************************************
echo .  
echo ================================================================================================================
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ________________________________________________________________________________________________________________
echo .
echo .
echo @@@  Creating CloudFront CDN :).........
echo .
echo .
"C:\Program Files\Amazon\AWSCLIV2\aws" cloudfront create-distribution --origin-domain-name %origin% --query Distribution.DomainName --output text > cloudfrontlink.txt
C:\Windows\System32\timeout 75
start https://console.aws.amazon.com/cloudfront/home?region=ap-south-1 
set /p Clink=<cloudfrontlink.txt

echo ====================================================================================================
echo -------------------------  CloudFront Created and uploaded ----------------------------------
echo ====================================================================================================

echo Cloudfront link= %Clink%           + file location
echo Example : Cloudlink="https://%Clink%/staticData/me.jpg"
set domain=kaushaltestings3.s3.ap-south-1.amazonaws.com
echo .
echo .
pause

:cdnweb
cls
echo .
echo .
echo ====================================================================================================
echo -------------------------  Website Creation with CDN : ----------------------------------
echo ====================================================================================================
echo .
echo ***
echo Now  update website with CDN links :
echo ***
echo Cloudfront link= %Clink%           + file location
echo Example : Cloudlink="https://%Clink%/staticData/me.jpg"
C:\Windows\System32\timeout 3
start website

echo ###  Once you done with website update then 
pause

cls
echo .
echo .
echo .
echo .
echo website hosting ...
C:\Windows\System32\OpenSSH\scp -i %accesskey% -r website ec2-user@%instanceIP%:~
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo cp -rf website /var/www/html/
C:\Windows\System32\OpenSSH\ssh -i %accesskey% ec2-user@%instanceIP% sudo systemctl restart httpd 
C:\Windows\System32\timeout 5
echo ====================================================================================================
echo -------------------------  Website Hosted and uploaded ----------------------------------
echo ====================================================================================================

echo ### ***  Access Site  on link : http://%instanceIP%/website/index.html 
start http://%instanceIP%/website/index.html 
pause
:option3
set /p choice3="Do you want again update website ( y/n ) : "
if %choice3% == y goto cdnweb
if %choice3% == n goto end 
if not %choice3% == y goto incorrect3


:incorrect3
echo *** Incorrect Input. Please enter again.
pause
goto option3
:end

cls
color f9
echo *
echo *
echo *
echo ====================================================================================================
echo ************************ THANKS To *****************************************
echo ************************ USE THIS  *****************************************
echo  *********************** SCRIPT    *****************************************
echo ====================================================================================================
echo *
echo *
echo *
echo *
echo *
echo ====================================================================================================
echo ************************ Created by *****************************************
echo ************************ KAUSHAL SONI  *****************************************
echo ====================================================================================================

echo *
C:\Windows\System32\timeout 2
cls
color e5
echo *
echo *
echo *
echo ====================================================================================================
echo ************************ THANKS To *****************************************
echo ************************ USE THIS  *****************************************
echo  *********************** SCRIPT    *****************************************
echo ====================================================================================================
echo *
echo *
echo *
echo *
echo *
echo ====================================================================================================
echo ************************ Created by *****************************************
echo ************************ KAUSHAL SONI  *****************************************
echo ====================================================================================================

echo *
C:\Windows\System32\timeout 2
cls
color 9f
echo *
echo *
echo *
echo ====================================================================================================
echo ************************ THANKS To *****************************************
echo ************************ USE THIS  *****************************************
echo  *********************** SCRIPT    *****************************************
echo ====================================================================================================
echo *
echo *
echo *
echo *
echo *
echo ====================================================================================================
echo ************************ Created by *****************************************
echo ************************ KAUSHAL SONI  *****************************************
echo ====================================================================================================

echo *
color 0f
C:\Windows\System32\timeout 3
pause
exit





