local discordia = require('discordia')
local client = discordia.Client()
local botToken = "NDg2NTk1Nzc4NzU3MDAxMjQ4.DnBa9Q._1xUewq0hth0D-EBoblfDQnJCGc"

local prefix = "."
local devPrefix = "*"
local jobPrefix = "-"

discordia.extensions()

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on("ready", function()
    client:setGame(prefix.."help".." / "..prefix.."admin")
end)

client:on("memberJoin", function(member)
    member:send("Witaj na discordzie sieci **Rage-Gangs.pl**, napisz na dowolnym kanale komendę `.help` aby uzyskać listę moich komend. \n \nPamiętaj, aby zajrzeć na zakładkę informacje, znajdziesz tam całą listę administracji, regulaminy oraz kanał do reportowania bugów. \n\nŻyczymy miłej zabawy :)\n\n**- Zarząd sieci RGngs**")
end)

client:on("messageCreate", function(message)

    if message.guild == nil then return end 
    if message.author.bot == true then return end 

	local content = message.content:lower()
	local author = message.author
    local member = message.guild.members:get(message.author.id)
    local args = content:split(" ")
    local channel = message.channel

    --[[ Checks ]]--
    if member:hasRole("484008135737081856") then 
        message:delete()
        member:send("Nie możesz wysyłać wiadomości ponieważ jesteś zmutowany, skontaktuj się z administratorem!")
    end

	--[[ Help Commands ]]--

    if args[1] == prefix.."help" then
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

    if args[1] == prefix.."admin" then
		message:reply {
			embed = {
				author = {
					name = author.username,
					icon_url = author.avatarURL
				},
				fields = { 
					{
						name = ".kick",
						value = "Kickuje użytkownika z discorda",
						inline = false
					},
					{
						name = ".clear",
						value = "Usuwa od 1-50 wiadomości z kanału",
						inline = false
					},
                    {
                        name = ".mute",
                        value = "Mutuje użytkownika",
                        inline = false
                    },
                    {
                        name = ".unmute",
                        value = "Odmutowuje użytkownika",
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

    --[[ General Commands ]]--

	if args[1] == prefix.."paczka" then 
        message:reply {
            content = "Oto paczka serwera CityRP: https://steamcommunity.com/workshop/filedetails/?id=599155037",
            mention = author,
        }
    end
    
    if args[1] == prefix.."sklep" then 
        message:reply {
            content = "Oto nasz sklep: https://sklep.rage-gangs.pl",
            mention = author,
        }
    end

    if args[1] == prefix.."apelacja" then 
        message:reply {
            content = "Zostałeś zbanowany? Złóż apelację na https://ban.rage-gangs.pl",
            mention = author,
        }
    end

    if args[1] == prefix.."ip" then 
        message:reply {
            content = "Oto IP CityRP: **185.11.103.89:27085**, możesz również dołączyć kilakając w steam://connect185.11.103.89:27085",
            mention = author,
        }
    end

    if args[1] == prefix.."verify" then 
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

    if args[1] == prefix.."nsfw" then 
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

    if args[1] == prefix.."discord" then 
        message:reply { 
            content = "Oto zaproszenie do naszego discorda, podaj koledze! https://discord.gg/eg52J5a",
            mention = author,
        }
    end

    --[[ Admin Commands ]]--

    if args[1] == prefix.."kick" then 
        if not member:hasRole("439738495515361300") then -- Moderator CityRP
            if not member:hasRole("439738097379311626") then -- Administrator CityRP
                if not member:hasRole("420596036914905090") then -- Super Administrator CityRP
                    if not member:hasRole("479771962583941120") then -- Developer CityRP
                        if not member:hasRole("420595329033830412") then -- Własciciel
                            message:reply("ERROR: Brak permisji!")
                            return
                        end
                    end
                end 
            end 
        end

        if args[2] == nil then message:reply("ERROR: Nie podałeś gracza którego chcesz zkickować") return end
        
        for k, v in pairs(message.mentionedUsers) do 
            local u = message.guild:getMember(v)
            if not u then return end

            if u:hasRole("439738495515361300") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("439738097379311626") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("420596036914905090") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("479771962583941120") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("420595329033830412") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("422374774610722816") then message:reply("ERROR: Użytkownik jest botem") return end

            u:kick("Kick nadany przez PandaBot")
            message.channel:send(u.mentionString.." został zkickowany".." przez "..author.tag)
        end
    end

    if args[1] == prefix.."clear" then 
        if not member:hasRole("439738495515361300") then -- Moderator CityRP
            if not member:hasRole("439738097379311626") then -- Administrator CityRP
                if not member:hasRole("420596036914905090") then -- Super Administrator CityRP
                    if not member:hasRole("479771962583941120") then -- Developer CityRP
                        if not member:hasRole("420595329033830412") then -- Własciciel
                            message:reply("ERROR: Brak permisji!")
                            return
                        end
                    end
                end 
            end 
        end

        if args[2] == nil then message:reply("ERROR: Nie podałeś liczby wiadomości do usunięcia (2-50)") return end

        amount = tonumber(args[2])
        if not amount then message:reply("ERROR: Nie podałeś liczby wiadomości do usunięcia (2-50)") return end
        if amount > 50 then message:reply("ERROR: Nie możesz usunąć więcej niż 50 wiadomości!") return end
        local msgTable = message.channel:getMessages(amount+1)
        local cachedMessages = {}

        message.channel:bulkDelete(msgTable)
        message.channel:send(amount.." wiadomości zostało usuniętych przez "..author.tag)
    end

    if args[1] == prefix.."mute" then 
        if not member:hasRole("439738495515361300") then -- Moderator CityRP
            if not member:hasRole("439738097379311626") then -- Administrator CityRP
                if not member:hasRole("420596036914905090") then -- Super Administrator CityRP
                    if not member:hasRole("479771962583941120") then -- Developer CityRP
                        if not member:hasRole("420595329033830412") then -- Własciciel
                            message:reply("ERROR: Brak permisji!")
                            return
                        end
                    end
                end 
            end 
        end

        if args[2] == nil then message:reply("Nie podałeś osoby którą chcesz zmutować") return end

        for k, v in pairs(message.mentionedUsers) do 
            local u = message.guild:getMember(v)
            if not u then return end

            if u:hasRole("439738495515361300") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("439738097379311626") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("420596036914905090") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("479771962583941120") then message:reply("ERROR: Użytkownik jest członkiem administracji") return end
            if u:hasRole("422374774610722816") then message:reply("ERROR: Użytkownik jest botem") return end

            u:addRole("484008135737081856")
            u:mute()
            message.channel:send(u.mentionString.." został zmutowany".." przez "..author.tag)
        end

    end

    if args[1] == prefix.."unmute" then 

        if not member:hasRole("439738495515361300") then -- Moderator CityRP
            if not member:hasRole("439738097379311626") then -- Administrator CityRP
                if not member:hasRole("420596036914905090") then -- Super Administrator CityRP
                    if not member:hasRole("479771962583941120") then -- Developer CityRP
                        if not member:hasRole("420595329033830412") then -- Własciciel
                            message:reply("ERROR: Brak permisji!")
                            return
                        end
                    end
                end 
            end 
        end

        if args[2] == nil then message:reply("ERROR: Nie podałeś osoby którą chcesz zmutować") return end

        for k, v in pairs(message.mentionedUsers) do 
            local u = message.guild:getMember(v)
            if not u then return end

            if u:hasRole("484008135737081856") then 
                u:removeRole("484008135737081856")
                u:unmute()
                message.channel:send(u.mentionString.." został odmutowany".." przez "..author.tag)
            else
                message.channel:send("ERROR: Użytkownik "..u.tag.." nie jest zmutowany!")
            end
        end

    end

    --[[ Developer Commands ]]--

    if args[1] == devPrefix.."info" then 
        message:delete()    
        message:reply {
            content = "[DEV] "..member.discriminator.." | "..member.id.." | "..member.tag.." | "..member.mentionString,
        }
    end

    if args[1] == devPrefix.."giver" then 
        if member.tag ~= "SaturdaysHeroes#4859" then message:reply("Brak permisji!") return end
        if args[2] == nil then message:reply("args[2] == nil") return end
        message:delete()
        member:addRole(args[2])
        message:reply {
            content = "[DEV] Nadano rangę "..args[2].."!",
        }
    end

     if args[1] == devPrefix.."remover" then 
        if member.tag ~= "SaturdaysHeroes#4859" then message:reply("Brak permisji!") return end
        if args[2] == nil then message:reply("args[2] == nil") return end
        message:delete()
        member:removeRole(args[2])
        message:reply {
            content = "[DEV] Zabrano rangę "..args[2].."!",
        }
    end

end)

client:run('Bot'.." "..botToken)