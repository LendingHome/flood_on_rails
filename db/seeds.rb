HighScore.destroy_all

HighScore.create!([
    {
        name: "Nomura",
        score: 0,
        size: 'Medium'
    },
    {
        name: "Fred",
        score: 0,
        size: 'Medium'
    },
    {
        name: "Greg",
        score: 0,
        size: 'Medium'
    },
    {
        name: "Tim",
        score: 0,
        size: 'Medium'
    },
    {
        name: "Bella",
        score: 0,
        size: 'Medium'
    },
    {
        name: "Jessica",
        score: 0,
        size: 'Medium'
    },
    {
        name: "Tiffany",
        score: 0,
        size: 'Medium'
    },
    {
        name: "Squeeps",
        score: 0,
        size: 'Medium'
    },
    {
        name: "Lending",
        score: 2,
        size: 'Medium'
    },
    {
        name: "Home",
        score: 1,
        size: 'Medium'
    },
])

User.destroy_all

User.create!({
    username: 'admin',
    email: 'none',
    password: 'admin' 
})
