#This is set the file to a variable
$File='C:\Users\Unknown_User\Desktop\users.csv'


#This is to dump the content of the file into a variable
$FileContent=get-content $File

#This is for the outputfile location
$Outputfile="C:\users\Unknown_user\Desktop\Output.csv"

#Creat the output file
New-Item $Outputfile -ItemType file


#This is the new header for the new output CSV file and teh variables for the header
$newsite='site'
$newtotalusercount='Totalusercount'
$newemployeecount='Employeecount'
$newcontractorcount='ContractorCount'
$newtotalmailboxsize='Totalmailboxsize'
$newAveragemailboxsize='Averagemailboxsize'

$header=$newsite+','+$newtotalusercount+','+$newemployeecount+','+$newcontractorcount+','+$newtotalmailboxsize+','+$newaceragemailboxsize

#add the header to the output file
$header|Add-Content -Path $Outputfile

$count=0

#need to set $i to 1 to skip the CSV header
$i=1

#other variables for logic procesing
$j=0
$k=0
$l=0
$m=0
$n=0



#mailboxes over 10 GBs
$a=0

#Totalmailboxsizeadded
$totalMailboxsize=0
#totalmailboxsizeforNYCsite
$totalMailboxsizeforNYC=0

#Get the total users in the list
$Totalusers=$FileContent.length-1

write-host("There are a total of "+$Totalusers+ " users")


do
{

#This variable will be used to loop through all of the entries
$emailaddress,$UserPrincipalname,$site,$Mailboxsize,$Accounttype=$filecontent[$i].split(',')


$totalMailboxsize=$totalMailboxsize+$Mailboxsize     

        #this loop compares the email address and the userpriciples name. If they match do nothing, if they dont add 1 to the counter.

        if($emailaddress.ToUpper() -eq $UserPrincipalname.ToUpper())
        {
        $j++


        }

        
        #This loop checks the site
        if($site.ToUpper() -eq "NYC")
        {
         $totalMailboxsizeforNYC=$totalMailboxsizeforNYC+$Mailboxsize

         
         $k++

        }
        
        
        #this loop checks mailbox size to see if its over 10 GBs
        if ($Mailboxsize -ge 10.0)
        {

        $l++

        }

        #This loop will look for the account type of "Employee" and then look to see if the email account is larger that 10GB then add 1 to the count
        if($Accounttype.ToUpper() -eq "EMPLOYEE" -and $totalMailboxsize -gt 10.0)
        {

        $m++

        }

        #this loop checks for contractor in accounttype
        if($Accounttype.ToUpper() -eq "CONTRACTOR")
        {
        $n++
        }


   

$i++
}while($i -le $filecontent.Length-2)


#1 is the begining of the list

#148 is the last in the list
write-host("")
write-host("The total size of ALL the mail boxes is "+$totalMailboxsize +" GBs")
write-host("")
write-host("The total number of email addresses matching the userprincipial name is "+$j)
write-host("")
write-host("The total size of ALL the mail boxes for site NYC is "+$totalMailboxsizeforNYC +" GBs")
write-host("")
write-host("The total number of accounts with a Mailboxsize over 10 GBs is "+$l)
write-host("")
write-host("The total number of accounts for 'Employees' that have a mailbox over 10 GB is "+$m)
write-host("")
write-host("The total number of accounts for 'Contractors' that have a mailbox over 10 GB is "+$n)
write-host("")
#Average mailbox size calculation
$averagemailboxsize=$totalMailboxsize/$totalusers

write-host("The average mailbox size is "+$averagemailboxsize + " GBs")

