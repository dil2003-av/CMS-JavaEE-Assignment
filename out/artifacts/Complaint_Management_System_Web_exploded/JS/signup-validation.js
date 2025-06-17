
alert("✅ JS Loaded Successfully!");

function validateSignupForm() {
    const form = document.forms["signupForm"];
    const username = form["username"].value.trim();
    const email = form["email"].value.trim();
    const password = form["password"].value.trim();
    const role = form["role"].value;

    if (username === "" || email === "" || password === "" || role === "") {
        alert("⚠️ All fields are required!");
        return false;
    }

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        alert("⚠️ Please enter a valid email address.");
        return false;
    }

    if (password.length < 6) {
        alert("⚠️ Password must be at least 6 characters long.");
        return false;
    }

    return true;
}
