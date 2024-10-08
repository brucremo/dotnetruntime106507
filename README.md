# Dotnet Runtime Issue 106507 Reproduction

## Steps

1. Run `sudo chmod +x ./restart.sh ./start.sh ./getdump.sh`

2. Under `docker-compose.yml`, update `<YourIp>` with your local machine's IP.

3. To build & kick off the containers, run `./start.sh`. This will also open a new terminal tab to restart the API container every 30s.

4. If you'd like to access Edgeshark to setup packet captures, access http://localhost:5001

5. Monitor the docker compose logs, at a certain point the client will hang and the API will keep restarting while the client is stuck. This can take anywhere from 15 to 30 minutes to occur.

6. Once you've confirmed the client is hung waiting for a response, run `./getdump.sh` to get the dotnet dump from the running client into the `./dumps` folder.

## Notes

### The Client is not "stuck forever" 

The issue seems to self-resolve and communication is resumed after the Server is rebooted a few (2-3) times while the Client is stuck waiting after an initial reboot. 

To speed up reproduction you can update the Server restart gap to 10s and the bad Client state should occur in around 10 minutes.