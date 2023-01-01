@echo off
REM Navigate to the repository directory
cd /d "C:\Users\reaper\Downloads\comm\commit"

REM Enable delayed expansion so variables update properly inside loops
setlocal enableextensions enabledelayedexpansion

REM Set the range for backdating (3 years)
set "startYear=2023"
set "endYear=2025"

REM Define commit messages in an array-like format
set "messages[0]=Update README"
set "messages[1]=Bug fix"
set "messages[2]=Code improvement"
set "messages[3]=Refactor code"
set "messages[4]=Add new feature"
set "messages[5]=Improve documentation"
set "messages[6]=Optimize performance"
set "messages[7]=Add tests for feature X"
set "messages[8]=Update dependencies"
set "messages[9]=Fix typo in comments"
set "messages[10]=Enhance UI design"
set "messages[11]=Update configuration files"
set "messages[12]=Clean up codebase"
set "messages[13]=Fix broken link in docs"
set "messages[14]=Add logging for debug purposes"
set "messages[15]=Improve error handling"
set "messages[16]=Remove unused imports"
set "messages[17]=Adjust layout for responsiveness"
set "messages[18]=Implement new feature"
set "messages[19]=Reorganize project structure"

REM Loop through each year, month, and day
for /L %%Y in (%startYear%,1,%endYear%) do (
    for /L %%M in (1,1,12) do (
        for /L %%D in (1,1,28) do (

            REM Generate a random number for frequency (0-6)
            set /a freq=!RANDOM! %% 7

            REM Only commit if freq < 3 (i.e. ~3 days out of 7)
            if !freq! LSS 3 (
                echo Processing %%Y-%%M-%%D -- freq=!freq!

                REM Ensure activity.txt exists and append something unique
                if not exist activity.txt (
                    echo Initializing activity file> activity.txt
                )
                echo Commit for %%Y-%%M-%%D at !time! >> activity.txt

                REM Pick a random index for the commit message
                set /a idx=!RANDOM! %% 20

                REM Call subroutine to get the actual message from the array
                call :setCommitMsg !idx!

                echo Commit message: "!commit_msg!"

                REM Backdate the commit
                set "GIT_COMMITTER_DATE=%%Y-%%M-%%D 12:00:00"
                set "GIT_AUTHOR_DATE=%%Y-%%M-%%D 12:00:00"

                REM Stage and commit
                git add activity.txt
                git commit -m "!commit_msg!" --date="%%Y-%%M-%%D 12:00:00"
            )
        )
    )
)

REM After all commits, push once at the end
echo Pushing all commits to GitHub...
git push origin main

REM Exit the script
goto :EOF


REM ------------- SUBROUTINE TO GET A MESSAGE FROM THE 'ARRAY' -------------
:setCommitMsg
  REM %1 is the index passed from the main loop
  set "commit_msg=!messages[%1]!"
  if "!commit_msg!"=="" (
    set "commit_msg=Default commit message"
  )
  goto :EOF
