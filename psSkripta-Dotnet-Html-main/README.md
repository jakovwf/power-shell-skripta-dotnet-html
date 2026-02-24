# PowershellSkripta-Dotnet-React

Najbolje je da se skine cela skripta kao zip u folder po želji.  

Kada se skripta skine, možete je pokrenuti pomoću PowerShella.  

Da bi se skripta mogla pokretati iz bilo kog foldera na računaru, mora da se doda lokacija skripte u PATH promenljivu.  

To se radi ovako:

---

## 1️⃣ Premesti skriptu u stalni folder

Napravi npr:  

C:\Scripts

Ubaci tamo svoju skriptu, npr:  

create-fullstack.ps1

---

## 2️⃣ Dodaj taj folder u PATH (jednom zauvek)

Koraci:  

- Win + S → “Environment Variables”  
- Klikni **Edit the system environment variables**  
- Dugme **Environment Variables**  
- U **User variables** pronađi **Path**  
- Klikni **Edit → New**  
- Dodaj:  

C:\Scripts

- Klikni **OK → OK → OK**  
- ⚠️ ZATVORI sve PowerShell / VS Code terminale i otvori ponovo

---

## 3️⃣ Dozvoli pokretanje skripti (ako već nisi)

U PowerShellu (kao USER, ne admin):  

Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

---

## 4️⃣ Pokretanje skripte – BILO GDE 🚀

Sada možeš u bilo kom folderu:

create-fullstack ili create-fullstack.ps1





