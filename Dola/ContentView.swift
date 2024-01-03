//
//  ContentView.swift
//  Dola
//
//  Created by Damian Ruta on 03/01/2024.
//

import SwiftUI

struct Person: Identifiable {
    let id = UUID()
    var Number: Int
    var Name: String
}

var timer = Timer() // zmienna do przechowywania timera
var randomNumber = 0 // zmienna do przechowywania losowej liczby
var timeLeft = 5 // zmienna do przechowywania pozostałego czasu

struct ContentView: View {
    
    
    @State var selectedNumber: String = "";
    @State var selectedPerson: String = "";
    @State var showingAlert: Bool = false;
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    List(Winers) { person in
                        HStack {
                            Text("\(person.Number).")
                            Text(" \(person.Name)")
                        }
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        HStack() {
                            Text("Wczytano nazwisk: ")
                                .fontWeight(.light)
                                .frame(width: 140.0, alignment: .leading)
                            Text(String(Persons.count))
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading, .trailing], 10.0)
                        
                        Divider()
                        HStack() {
                            Text("Wylosowano nazwisk: ")
                                .fontWeight(.light)
                                .frame(width: 140.0, alignment: .leading)
                            Text(String(Winers.count))
                                .fontWeight(.bold)
                                
                                
                        }
                        .padding([.leading, .bottom, .trailing], 10.0)
                    }
                }
                .frame(width: max(geometry.size.width * 0.3, 300))
                
                Divider()
                
                HStack() {
                    Spacer()
                    VStack(alignment: .center) {
                        Spacer()
                        VStack(alignment: .center) {
                            Text(selectedNumber)
                                .font(.system(size: 160))
                                .multilineTextAlignment(.center)
                        }
                        .frame(minHeight: geometry.size.height * 0.5)
                        Spacer()
                        VStack() {
                            Text(selectedPerson)
                                .font(.title)
                                .fontWeight(.bold)
                                .animation(.easeInOut(duration: 0.3), value: selectedPerson)
                        }
                        Spacer()
                        Divider()
                        HStack {
                            Button(action: startTimer, label: {
                                Text("LOSUJ")
                                    .font(.headline)
                                    .padding(.all, 10.0)
                            })
                            .padding(.vertical, 20.0)
                        }
                    }
                    Spacer()
                }
            }
        }
        .alert("Nie mam już z czego losowac :(", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
    }
    
    // funkcja do rozpoczęcia timera
    func startTimer() {
        withAnimation (.easeInOut(duration: 1)) {
            timer.invalidate() // na wypadek, gdyby przycisk został naciśnięty kilka razy
            // rozpoczęcie timera z interwałem 1 sekundy, powtarzającym się i wywołującym funkcję timerAction
        //     timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            if (Winers.count < Persons.count) {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    selectedNumber = "0";
                    selectedPerson = "";
                    
                    randomNumber = Int.random(in: 1...10) // losowanie liczby z zakresu 1 - 10
                    selectedNumber = String(randomNumber) // wyświetlanie liczby w polu tekstowym
                    timeLeft -= 1 // zmniejszanie pozostałego czasu
                    if timeLeft == 0 { // jeśli czas się skończył
                        timer.invalidate() // zatrzymanie timera
                        let person = Persons[randomNumber - 1] // wybranie osoby z tablicy Persons na podstawie losowej liczby
                        Winers.append(person) // dodanie osoby do tablicy Winers
                        selectedPerson = person.Name // wyświetlenie imienia osoby w polu tekstowym
                        timeLeft = 5 // zresetowanie pozostałego czasu
                    }
                }
            } else {
                showingAlert = true;
            }
        }
        
    }
}

var Persons = [
    Person(Number: 1, Name: "John"),
    Person(Number: 2, Name: "Jane"),
    Person(Number: 3, Name: "Jack"),
    Person(Number: 4, Name: "John"),
    Person(Number: 5, Name: "Jane"),
    Person(Number: 6, Name: "Jack"),
    Person(Number: 7, Name: "John"),
    Person(Number: 8, Name: "Jane"),
    Person(Number: 9, Name: "Jack"),
    Person(Number: 10, Name: "Jack"),
    Person(Number: 11, Name: "Jack"),
    Person(Number: 12, Name: "Jack"),
    Person(Number: 13, Name: "Jack"),
    Person(Number: 14, Name: "Jack"),
    Person(Number: 15, Name: "Jack")
]

var Winers = [Person]()





// funkcja wywoływana przez timer
//func timerAction() {
//    randomNumber = Int.random(in: 1...10) // losowanie liczby z zakresu 1 - 10
//     self.timerTextField.text = String(randomNumber) // wyświetlanie liczby w polu tekstowym
//    timeLeft -= 1 // zmniejszanie pozostałego czasu
//    if timeLeft == 0 { // jeśli czas się skończył
//        timer.invalidate() // zatrzymanie timera
//        let person = Persons[randomNumber - 1] // wybranie osoby z tablicy Persons na podstawie losowej liczby
//        Winers.append(person) // dodanie osoby do tablicy Winers
//         self.nameTextField.text = person.Name // wyświetlenie imienia osoby w polu tekstowym
//        timeLeft = 5 // zresetowanie pozostałego czasu
//    }
//}


#Preview {
    ContentView()
        .frame(width: 800, height: 500)
}
