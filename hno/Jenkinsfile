def TEST_DNS
def TEST_PASSWORD
pipeline {
    agent {
        node {
            label 'SlaveWindows'
			customWorkspace 'C:\\Jenkins\\workspace\\CreationCertifcat\\CREATION-CERTIF-PIP'
        }
    }
    parameters {
		  validatingString defaultValue: '', description: '''Common Name : Exemple 
		*.seb.com''', failedValidationMessage: 'CN : Should Not Be Empty', name: 'CN', regex: '^(?!\\s*$).+'
		  validatingString defaultValue: '', description: '''Enter a unique friendly name for the certificate 
		*.seb.com''', failedValidationMessage: 'Freindly Name Should Not Be Empty', name: 'FreindlyName', regex: '^(?!\\s*$).+'   
		  string description: '''Please use \'%\' to separate between DNS

		If Left Empty, Only the CN will be used ''', name: 'DNS'	
		  password defaultValue: '', description: '''Please create a password, 
		if field is empty, a password of 8 characters will be automatically created  ''', name: 'PASSWORD'
		  validatingString defaultValue: '', description: '''Email address for which the certificate will be sent. 
		Please use \' , \' to separate between adresses.
		To CC or BCC someone instead of putting them in the To list, add cc: or bcc: before the email address (e.g., cc:someone@example.com, bcc:bob@example.com).''', failedValidationMessage: 'Please Enter Email Address', name: 'Email', regex: '^(?!\\s*$).+'
	
	}
  stages {

			stage("Testing Parameters") {
            steps {
				script {
					if ( DNS == "") {
						echo "EMPTY DNS, CN WILL BE USED"
						ENV:TEST_DNS = "EMPTY"
					}else {
						echo " "
					}
					if ( PASSWORD == "") {
						echo "EMPTY PASSWORD, AN AUTOMATIC PASSWORD WILL BE CREATE"
						ENV:TEST_PASSWORD = "EMPTY"
					}else {
						echo " "
					}					
				}
            }
        }

			stage('Execution') {
            steps {
				echo "The workspace is ${ENV:WORKSPACE}"
				echo "The PASSWORD is ${ENV:BUILD_ID}"
                    powershell(''' 
                    ./CreateCert/CreateCert.ps1 $ENV:BUILD_ID $ENV:CN $ENV:FreindlyName $ENV:TEST_DNS $ENV:TEST_PASSWORD $ENV:WORKSPACE
                    ''')
            }
		}
	
    }
		post {
		success {
				emailext body: '''
				<html>
				$BUILD_NUMBER - $JOB_NAME - $BUILD_STATUS <br>
				The password is :  
				<b> ${FILE, path="C://Jenkins//workspace//CreationCertifcat//CREATION-CERTIF-PIP//CreateCert//KeyPass.txt"} </b> 
				</html>''' , 
				subject: '$BUILD_NUMBER - $JOB_NAME - $BUILD_STATUS' , attachmentsPattern: '**\\CreateCert\\TEMP\\*.7z',
				to : '$Email'
			}
		}
}
