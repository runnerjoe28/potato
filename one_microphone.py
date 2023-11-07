# Python script that employs the thread swapping approach to listen for keyword

# Library imports
import threading, os
import speech_recognition as sr
from playsound import playsound

# Global constants
MAGIC_WORD = "thanksgiving"
LISTEN_TIME = 5 # seconds

# Initialize recognizer class (for recognizing the speech)
speech_recognizer = sr.Recognizer()

# Global variables for thread switches
speech_audio_active = None
speech_audio_record = None

################################################################################

# Threading Functions

def thread_listen():
    # Reading Microphone as source
    # Listening to the speech and store in audio_text variable
    try:
        with sr.Microphone() as source:

            # Listen for 10 seconds
            print("Begin speech listening")
            # LOOK AT SNOWBOY SUPPORT
            global speech_audio_active
            speech_audio_active = speech_recognizer.listen(source, phrase_time_limit=LISTEN_TIME)
            print("Done listening")

    except Exception as ex:
        print("An error was encountered during listening", ex)

def thread_recognize():
    global speech_audio_record
    if (speech_audio_record == None):
        return
    print("Recognition Thread")
    try:
        # Surround in try catch to avoid any thrown errors from recognizition fails
        raw_text = speech_recognizer.recognize_google(speech_audio_record)
        words_spoken = raw_text.split()

        # Cycle through each word spoken to search for magic word
        for word in words_spoken:
            print(word.lower())
            if MAGIC_WORD == word.lower():
                print("DID SOMEBODY SAY THANKSGIVING!")
                playsound('smol.wav')
        
        print()
    except Exception as ex:
        print("An error was encountered during recognizition", ex)

################################################################################

if __name__ =="__main__":

    for i in range(50):

        print("Iteration ", i)

        # Create and start multiple threads
        listening_thread = threading.Thread(target=thread_listen)
        recognize_thread = threading.Thread(target=thread_recognize)
        listening_thread.start()
        recognize_thread.start()

        # Wait for all threads to finish
        listening_thread.join()
        recognize_thread.join()
        speech_audio_record = speech_audio_active
        speech_audio_active = None