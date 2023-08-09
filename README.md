<h1>File Integrity Monitor</h1>

<h2>Description</h2>
A File Integrity Monitor using PowerShell is a script that continuously compares the hash values of files against a baseline, alerting administrators to unauthorized changes. It helps maintain data integrity and detect potential security breaches.
<br />


<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b> 

<h2>Environments Used </h2>

- <b>Windows 10 / Windows 11</b> 

<h2>Program walk-through:</h2>

<p align="center">
Launch the utility: <br/>

 Everything needed for the File Integrity Check:  <br/>
![](images/p1.png)

<br />
<br />


Targeting Folder with valuable information:  <br/>
![](images/p3.png)
<br />
<br />

Run the MakeBaselineHash to get the original untampered hashes of files:  <br/>
![](images/p4.png)
<br />
<br />

Baseline hashes:  <br/>
![](images/p5.png)
<br />
<br />

Perpetrator goes into the system and steals your address without consent:  <br/>
![](images/p6.png)
<br />
<br />

Run the CheckFileIntegrity command and check what files have been altered:  <br/>
![](images/p7.png)
<br />
<br />

The previous command shows that the "PII.txt"'s hash has been changed and was notified:  <br/>
![](images/p8.png)
<br />
<br />



Inspired by Zach<br/>
