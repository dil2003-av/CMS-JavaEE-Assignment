function validateLoginForm() {
    const email = document.forms["loginForm"]["email"].value.trim();
    const password = document.forms["loginForm"]["password"].value.trim();

    if (email === "" || password === "") {
        alert("⚠️ Please fill out both email and password fields.");
        return false;
    }

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        alert("⚠️ Please enter a valid email address.");
        return false;
    }

    return true;
}
