#Use Python for running server
FROM python:3

#Copy files from /build/web dir
ADD /build/web /flutterDir

#Go to dir
WORKDIR /flutterDir

#Expose this port for web flutter
EXPOSE 8000

#Start server
ENTRYPOINT python -m http.server
