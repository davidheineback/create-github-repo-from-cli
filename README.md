## Create a github repo and push current directory to it.
This reposotirium contains a bash script that is to be used for creating new repositoriums at [GitHub](https://github.com/) directly from the terminal and then push your local directory to the newly created GitHub repostorium.

  ### Username:
  - Add your github username as string in the USERNAME variable
    - Example: USERNAME='GitHubUsername'  

  ### Handle token:
- Log in to your GitHub account
- Go to Settings > Developer settings
- Create a personal access token (PAT)
  - PAT needs repo rights.

  - #### On MAC:  
For macOS you can choose to either write the github PAT directly in the variable or to use grep and place token in separate file and just add path to the file as example between <> below.  

  - Token string string example:
    - AUTH_TOKEN:"abc_aopdkpok32093r2dcmkwd"

  - Token file example:
    - Create a text file with .rtf format
    - Add the token to the file, should look something like this:  
    - token abc_aopdkpok32093r2dcmkwd
  - In the .sh file replace the example <path> in the regex string.
    - AUTH_TOKEN=`grep -oE 'token [^\}]+' <~/scripts/tokens/add-to-github-token.rtf> | sed 's/token //g'`

- #### On Windows:
  - grep is not currently implemented for windows so instead of creating a separate token file just add the token as a strint in the AUTH_TOKEN variable.

### Run the script
- In the terminal cd in to the directory you want to add to github
-To run script:
  - In terminal cd to the directory you want to add to github
  - run: sh /path/to/script
    - ex. sh ~/scripts/add-to-github.sh

- Follow the prompts
- DONE
