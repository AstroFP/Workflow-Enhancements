# What is RunGitbashHere?

**It allows a user to type `gitbash` in CMD, which would result in running Git Bash in the _current_ directory.**

---

For educational purposes I wanted to learn how to make that functionality setup itself by just running `setup.bat`.

After `setup.bat` is run, you can enter the command `gitbash` in any directory on CMD, and it will run Git Bash there.
> **Note:** The script was tested to be working on **Windows 10/11**, and you need to have **PowerShell** for it to work.

---

However, if you don't trust my programming skills and you don't want to run my `setup.bat` that plays with the **PATH** variable  
(I do create backups so what could go wrong 😅), you can achieve the same manually by:

### 1. Create a `.bat` file with this command  
*(Change `%path%` into your Git folder—wherever you installed Git on your computer):*

start "" "%path%\git-bash.exe" --cd=%cd%

### 2. Add the folder where your script is located to the **PATH** variable  
*(User or System, whichever you prefer)*
