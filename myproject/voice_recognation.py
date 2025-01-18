import speech_recognition as sr

# Initialize recognizer class (for recognizing the speech)
recognizer = sr.Recognizer()

# Use the microphone as the audio source
with sr.Microphone() as source:
    print("Adjusting for ambient noise... Please wait.")
    recognizer.adjust_for_ambient_noise(source, duration=1)  # Calibrate for ambient noise
    print("Say something!")
    
    # Listen for the first phrase
    audio = recognizer.listen(source)

    try:
        # Recognize the speech using Google's speech recognitionn
        #app
        print("You said: " + recognizer.recognize_google(audio))
    except sr.UnknownValueError:
        print("Sorry, I could not understand that.")
    except sr.RequestError:
        print("Sorry, the speech recognition service is down.")
