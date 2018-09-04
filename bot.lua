local discordia = require('discordia')
local client = discordia.Client()
local botToken = ""

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on("ready", function()
    client:setGame(".help")
end)

client:on("messageCreate", function(message)

	local content = message.content
	local author = message.author
    local member = message.guild.members:get(message.author.id)
    local prefix = "."

	if content == prefix.."help" then
		message:reply {
			embed = {
				author = {
					name = author.username,
					icon_url = author.avatarURL
				},
				fields = { 
					{
						name = ".paczka",
						value = "Wysyła link do paczki serwera CityRP",
						inline = false
					},
					{
						name = ".sklep",
						value = "Wysyła link do naszego sklepu",
						inline = false
					},
                    {
                        name = ".apelacja",
                        value = "Wysyła link do strony z apelacjami",
                        inline = false
                    },
                    {
                        name = ".ip", 
                        value = "Wysyła IP serwera oraz link do dołączenia",
                        inline = false
                    },
                    {
                        name = ".verify",
                        value = "Weryfikuje autora wiadomości",
                        inline = false
                    },
                    {
                        name = ".nsfw",
                        value = "Nadaje dostęp do kanałów NSFW",
                        inline = false
                    }
				},
				footer = {
					text = "Stworzone przez SaturdaysHeroes#4859"
				},
				color = 0xFF8C00 
			}
		}
    end 

	if content == prefix.."paczka" then 
        message:reply("Oto paczka serwera CityRP: https://steamcommunity.com/workshop/filedetails/?id=599155037")
    end
    
    if content == prefix.."sklep" then 
        message:reply("Oto nasz sklep: https://sklep.rage-gangs.pl")
    end

    if content == prefix.."apelacja" then 
        message:reply("Zostałeś zbanowany? Złóż apelację na https://ban.rage-gangs.pl")
    end

    if content == prefix.."ip" then 
        message:reply("Oto IP CityRP: **185.11.103.89:27085**, możesz również dołączyć kilakając w steam://connect185.11.103.89:27085 ")
    end

    if content == prefix.."verify" then 
        if member:hasRole("479777556678311955") == true then 
            message:reply("Użytkownik jest już zweryfikowany!") 
        end

        if member:hasRole("479777556678311955") == false then 
            member:addRole("479777556678311955")
            message:reply("Użytkownik został zweryfikowany!")
        end
    end

    if content == prefix.."nsfw" then 
        if member:hasRole("481204052093435915") == true then 
            message:reply("Użytkownik posiada już rangę NSFW") 
        end

        if member:hasRole("481204052093435915") == false then 
            member:addRole("481204052093435915")
            message:reply("Użytkownik otrzymał rangę NSFW")
        end
    end

end)

client:run('Bot'.." "..botToken)