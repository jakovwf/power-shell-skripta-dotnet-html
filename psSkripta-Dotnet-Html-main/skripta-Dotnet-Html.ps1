# ====== CONFIG ======
$ProjectName = "MyFullStackApp"
$BackendName = "Backend"

# ====== ROOT FOLDER ======
New-Item -ItemType Directory -Name $ProjectName -Force | Out-Null
Set-Location $ProjectName

# ====== BACKEND FOLDER & PROJECT ======
New-Item -ItemType Directory -Name $BackendName -Force | Out-Null
Set-Location $BackendName
dotnet new web

# ====== CREATE wwwroot AND BASIC FRONTEND FILES ======
$wwwroot = "wwwroot"
New-Item -ItemType Directory -Name $wwwroot -Force | Out-Null
Set-Location $wwwroot

# ====== index.html ======
@"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My FullStack App</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Hello from Frontend!</h1>
    <script src="main.js"></script>
</body>
</html>
"@ | Out-File -Encoding UTF8 index.html

# ====== style.css ======
@"
body {
    font-family: Arial, sans-serif;
    text-align: center;
    margin-top: 50px;
}
"@ | Out-File -Encoding UTF8 style.css

# ====== main.js ======
@"
console.log('Frontend is working!');

// Dinamički napravimo dugme za test
const button = document.createElement('button');
button.textContent = 'Pošalji poruku backend-u';
document.body.appendChild(button);

button.addEventListener('click', () => {
    const data = { message: 'Zdravo backend!' };

    fetch('http://localhost:5000/api/data/submit', {  // fiksni port 5000
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => {
        console.log('Odgovor backend-a:', result);
        const p = document.createElement('p');
        p.textContent = 'Backend odgovorio: ' + result.received;
        document.body.appendChild(p);
    })
    .catch(err => console.error(err));
});
"@ | Out-File -Encoding UTF8 main.js

Set-Location ..

# ====== OVERWRITE Program.cs ======
$programPath = "Program.cs"
@"
var builder = WebApplication.CreateBuilder(args);

// Fiksni port 5000
builder.WebHost.UseUrls("http://localhost:5000");

// Omogućava CORS za frontend (ako se pokreće na drugom portu)
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

var app = builder.Build();

app.UseCors(); // Omogućava CORS
app.UseDefaultFiles(); // Omogućava index.html kao default
app.UseStaticFiles();  // Servira CSS i JS iz wwwroot

// API ruta
app.MapGet("/api/data/hello", () =>
{
    return Results.Json(new { message = "Hello from Backend!" });
});

// API ruta za POST (primanje podataka sa frontend-a)
app.MapPost("/api/data/submit", async (HttpRequest request) =>
{
    var body = await new StreamReader(request.Body).ReadToEndAsync();
    Console.WriteLine("Received from frontend: " + body);
    return Results.Json(new { status = "ok", received = body });
});

app.Run();
"@ | Out-File -Encoding UTF8 $programPath -Force

# ====== OPEN PROJECT IN VS CODE ======
Set-Location ..
code .

# ====== START BACKEND (NEW TERMINAL) ======
# ====== START BACKEND (NEW TERMINAL) ======
$fullPath = "$PWD\$BackendName"

Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd `"$fullPath`"; dotnet run"


Write-Host "✅ Full-stack projekat je kreiran i pokrenut na portu 5000!" -ForegroundColor Green
