# Remote Connect Instruction

1. Open a terminal (on MacOS or Linux) or cmd (on Windows 10 1809 or later)
    ```
    ssh myutorid@rdp1.teach.cs.toronto.edu -L3388:localhost:3389

    # Myutorid is your Teaching Labs name, usually the same as your UTORid. rdp2.teach.cs.toronto.edu works too; use that if rdp1 is overloaded or broken.
    ```

2. When prompted, log in using your Teaching Labs password.

3. Don't close the terminal (keep ssh running).

4. Start your remote desktop client and connect to localhost:3388. Log in using your Teaching Labs username and password (weixuanq; Weixq_211122).
    1. the remote destop client diff by the system: 
        1. For Windows 10, you can use Remote Desktop Connection, which is included in Windows. 
        2. On MacOS, get Microsoft Remote Desktop from the Apple store. 
        3. For Linux or UNIX variants, you can use remmina (with colour depth GFX RFX) or rdesktop, as supplied by your distribution.