import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()
def jenkinsHome = "/var/lib/jenkins"
File adminCreatedMarker = new File(jenkinsHome, ".adminCreatedmark")
println "mark file path : $adminCreatedMarker"

def username = "admin"
def password = "admin0987"

if (adminCreatedMarker.exists()) {
    println "admin user already exists. skip creating user."
} else {
    def hudsonRealm = new HudsonPrivateSecurityRealm(false)
    println "admin does not exists. creating admin...."
    hudsonRealm.createAccount(username,password)
    instance.setSecurityRealm(hudsonRealm)

    def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
    strategy.setAllowAnonymousRead(false)
    instance.setAuthorizationStrategy(strategy)

    instance.save()
    adminCreatedMarker.createNewFile()
    println "$adminCreatedMarker file created."
}
