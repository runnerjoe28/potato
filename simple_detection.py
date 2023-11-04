# Python script that will listen for 10 second intervals for the word thanksgiving

# Library imports
import speech_recognition as sr
from playsound import playsound

# Global constants
MAGIC_WORD = "thanksgiving"

# Initialize recognizer class (for recognizing the speech)
speech_recognizer = sr.Recognizer()

################################################################################

# Reading Microphone as source
# Listening to the speech and store in audio_text variable
with sr.Microphone() as source:

    # Listen for 10 seconds
    print("Begin speech listening")
    # LOOK AT SNOWBOY SUPPORT
    speech_audio = speech_recognizer.listen(source, phrase_time_limit=10)
    print("Done listening, preparing word list")

    # Surround in try catch to avoid any thrown errors from recognizition fails
    raw_text = speech_recognizer.recognize_google(speech_audio)
    words_spoken = raw_text.split()

    # Cycle through each word spoken to search for magic word
    for word in words_spoken:
        print(word.lower())
        if MAGIC_WORD == word.lower():
            print("DID SOMEBODY SAY THANKSGIVING!")
            playsound("smol.wav")
    
    print()