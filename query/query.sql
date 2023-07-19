/* © 2023 Tushar Aggarwal. All rights reserved. 
@https://github.com/tushar2704/
Instagram-User-Analytics
*/


/*A) Marketing:*/

--Rewarding Most Loyal Users: Finding the 5 oldest users of Instagram from the database.
SELECT *
FROM users
ORDER BY created_at ASC
LIMIT 5;


--Remind Inactive Users to Start Posting: Finding the users who have never posted a single photo on Instagram.
SELECT u.id, u.username, u.created_at
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
WHERE p.id IS NULL;

--Declaring Contest Winner: Identifing the winner of the contest and provide their details to the team (the user with the most likes on a single photo).
SELECT u.id, u.username, p.id AS photo_id, COUNT(l.user_id) AS likes_count
FROM users u
JOIN photos p ON u.id = p.user_id
LEFT JOIN likes l ON p.id = l.photo_id
GROUP BY u.id, u.username, p.id
ORDER BY likes_count DESC
LIMIT 1;


--Hashtag Researching: Identifing and suggest the top 5 most commonly used hashtags on the platform.
SELECT tag_name, COUNT(*) AS hashtag_count
FROM photo_tags
JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tag_name
ORDER BY hashtag_count DESC
LIMIT 5;

--Launch AD Campaign: Determining the day of the week when most users register on Instagram to schedule an ad campaign.
SELECT EXTRACT(DOW FROM created_at) AS day_of_week, COUNT(*) AS user_count
FROM users
GROUP BY day_of_week
ORDER BY user_count DESC
LIMIT 1;




/*B) Investor Metrics:*/

--User Engagement: Providing the average number of posts per user on Instagram and the total number of photos on Instagram divided by the total number of users.
-- Average number of posts per user
SELECT COUNT(*) / COUNT(DISTINCT user_id) AS average_posts_per_user
FROM photos;

-- Total number of photos on Instagram / Total number of users
SELECT COUNT(*) AS total_photos, COUNT(DISTINCT user_id) AS total_users
FROM photos;

--Bots & Fake Accounts: Providing data on users (bots) who have liked every single photo on the site.
SELECT user_id
FROM photos
GROUP BY user_id
HAVING COUNT(DISTINCT id) = (SELECT COUNT(DISTINCT id) FROM photos);


/*--------------------END--------------------------*/





















































































