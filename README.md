# scu-arm-cpu-jazb


How to get it to show up on jira:

To reference Jira issues while committing, building, and deploying code with Bitbucket, GitHub, or other supported developer tools:

Find the issue key for the Jira issue you want to link to, for example “JRA-123”. You can find the key in several places in Jira:
• On the board, issue keys appear at the bottom of a card.
• On the issue’s details, issue keys appear in the breadcrumb navigation at the top of the page.
Learn more about issues and issue keys.

Checkout a new branch in your repo, using the issue key in the branch name. For example, git checkout -b JRA-123-<branch-name>. 

When committing changes to your branch, use the issue key in your commit message to link those commits to the development panel in your Jira issue. For example, git commit -m "JRA-123 <summary of commit>".

When you create a pull request, use the issue key in the pull request title.

You need to push something to the connected repository for your tools to recognize and sync with Jira. Sometimes, it may take a few minutes for a complete sync to happen.

After you push your branch, you’ll see development information in your Jira issue. 

Including the issue key in the title of your pull request will automatically create a link to Jira.

Not seeing anything? Make sure you’ve formatted the Jira issue key correctly, using capital letters. For example, “JRA-123”, not “jra-123”. 
