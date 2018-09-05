local discordia = require('discordia')
local client = discordia.Client()
local botToken = "NDg2NTk1Nzc4NzU3MDAxMjQ4.DnBa9Q._1xUewq0hth0D-EBoblfDQnJCGc"

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on("ready", function()
    client:setGame(".help")
end)

client:on("memberJoin", function(member)
    member:send("test123")
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
                        name = ".discord",
                        value = "Wysyła link zapraszający do naszego discorda",
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
        message:reply {
            content = "Oto nasz sklep: https://sklep.rage-gangs.pl",
            mention = author,
        }
    end

    if content == prefix.."apelacja" then 
        message:reply {
            content = "Zostałeś zbanowany? Złóż apelację na https://ban.rage-gangs.pl",
            mention = author,
        }
    end

    if content == prefix.."ip" then 
        message:reply {
            content = "Oto IP CityRP: **185.11.103.89:27085**, możesz również dołączyć kilakając w steam://connect185.11.103.89:27085",
            mention = author,
        }
    end

    if content == prefix.."verify" then 
        if member:hasRole("479777556678311955") == true then 
            message:reply {
                content = "Jesteś już zweryfikowany!",
                mention = author,
            }
        end

        if member:hasRole("479777556678311955") == false then 
            member:addRole("479777556678311955")
            message:reply {
                content = "Zostałeś zweryfikowany!",
                mention = author,
            }
        end
    end

    if content == prefix.."nsfw" then 
        if member:hasRole("481204052093435915") == true then 
            message:reply {
                content = "Posiadasz już rangę NSFW",
                mention = author,
            }
        end

        if member:hasRole("481204052093435915") == false then 
            member:addRole("481204052093435915")
            message:reply { 
                content = "Otrzymałeś rangę NSFW",
                mention = author,
            }
        end
    end

    if content == prefix.."discord" then 
        message:reply { 
            content = "Oto zaproszenie do naszego discorda, podaj koledze! https://discord.gg/eg52J5a",
            mention = author,
        }
    end

end)

client:run('Bot'.." "..botToken)