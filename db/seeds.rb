HighScore.destroy_all

HighScore.create!([
    {
        name: "Nomura",
        score: 0 
    },
    {
        name: "Fred",
        score: 0
    },
    {
        name: "Greg",
        score: 0 
    },
    {
        name: "Tim",
        score: 0
    },
    {
        name: "Bella",
        score: 0
    },
    {
        name: "Jessica",
        score: 0
    },
    {
        name: "Tiffany",
        score: 0 
    },
    {
        name: "Squeeps",
        score: 0
    },
    {
        name: "Lending",
        score: 2
    },
    {
        name: "Home",
        score: 1 
    },
])

User.destroy_all

User.create!({
    username: 'admin',
    email: 'none',
    password: 'admin' 
})