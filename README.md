 # Devops task

## [Task 1: Git/GitHub]
Additional information:
1.	Read about Git https://git-scm.com/doc
 
Tasks:
0.  Create a Github account(if you don’t have one).
1.	Create new Github repository.
2.	Create Task1 folder in the master branch. Create and push ./Task1/README.md file.
3.	Create new branch dev. Create and push any test file.
4.	Create new branch %USERNAME-new_feature.
5.	Add README.md file to your %USERNAME-new_feature branch
6.	Check your repo with git status command
7.	Add .gitignore file to ignore all files whose name begins “.”
8.	Commit and push changes to github repo.
9.	Create Pull Request to the dev branch.
10.	Merge your branch with the dev branch and create Pull Request to the master branch. Merge dev with master.
11.	Checkout to %USERNAME-new_feature, make changes in README.md and commit them. Revert last commit in %USERNAME-new_feature branch.
12.	Check your repo with git log command, create log.txt file in master branch and save “git log” output in it.
13.	Delete local and remote branch %USERNAME-new_feature.
14.	 Add all used command to the git_commands.md file in the dev branch.
15.	 Send the link to your Git Repository to your mentor via private Skype message.


## [Task 2: AWS Cloud]
(Note. The assignment is written using AWS as an example. You can complete the assignment using any cloud services.)

Before completing this task, it is recommend check this video:
 https://www.youtube.com/watch?v=O1_--7IvP5g&list=PLg5SS_4L6LYsxrZ_4xE_U95AtGsIB96k9 (RU)


Important moments:
1.	Read about Cloud Services. Pro and Cons Cloud VS Bare Metal infrastructure?
2.	Read about Region, Zone in AWS. What are they for, which one will you use?
3.	Read about AWS EC2, what is it, what is it useful for?
4.	Read about AWS VPC (SG, Route, Internet Gateway).
5.	If you sign up in AWS for the first time, you will have the opportunity to use SOME AWS services for free (free tier) for 1 year. To register, you need a credit card from which it will be debited and returned 1-2$.
6.	Read about AWS Free Tier. There should be a clear of what will be free for new users and what will have to be paid for your own money.

Tasks:
1.	Sign up for AWS, familiarize yourself with the basic elements of the AWS Home Console GUI.
2.	Explore AWS Billing for checking current costs. 
3.	Create two EC2 Instance t2.micro with different operating systems (Amazon linux / Ubuntu ...). Try to stop them, restart, delete, recreate.
4.	Make sure there is an SSH connection from your host to the created EC2. What IP EC2 used for it?
5.	Make sure is an ping and SSH passed from one instance to another and vice versa. Configure SSH connectivity between instances using SSH keys.
6.	Install web server (nginx/apache) to one instance; 
- Create web page with text “Hello World” and information about OS version;
- Make sure web server accessible from internet and you can see your web page “Hello World” in your browser; 
- Make sure in instance without nginx/apache you can see “Hello world” from instance with nginx/apache.

 

EXTRA: 
1.	Run steps 3-6 with instances created in different VPC. (connectivity must be both external and internal IP)	
2.	Write BASH script for installing web server (nginx/apache) and creating web pages with text “Hello World”, and information about OS version
3.	Run step.6 without “manual” EC2 SSH connection.

The result of this task is a link in your github to the “Hello World” web page on AWS. After checking task by the mentor, the instance may be deleted. EXTRA tasks are passed to mentors individually. 





