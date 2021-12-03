extends Node

#Player Functions
func FetchPlayerData(_username, _password, _serverId):
	var result
	var token
	var hashedPassword
	if not PlayerData.playerData.has(_username):
		result = false
	else:
		var retrivedSalt = PlayerData.playerData[_username].salt
		hashedPassword = GenerateHashedPassword(_password, retrivedSalt)
		if not PlayerData.playerData[_username].password == hashedPassword:
			result = false
		else:
			result = true
			randomize()
			token = str(randi()).sha256_text() + str(OS.get_unix_time())
			Servers.DistributeLoginToken(token, _serverId)
	return [result, token]

#Password Functions
func GenerateSalt():
	randomize()
	var salt = str(randi()).sha256_text()
	#print("Salt: " + salt)
	return salt

func GenerateHashedPassword(password, salt):
	#print(str(OS.get_system_time_msecs()))
	var hashedPassword = password
	var rounds = pow(2, 18) #8 pow(2, 18) 262144
	#print("Hashed Password as Input: " + hashedPassword)
	while rounds > 0:
		hashedPassword = (hashedPassword + salt).sha256_text()
		#print("Password@ round: " + str(rounds) + "is: " + hashedPassword)
		rounds -=1
	#print("Final Hashed Password: " + hashedPassword)
	#print(str(OS.get_system_time_msecs()))
	return hashedPassword
