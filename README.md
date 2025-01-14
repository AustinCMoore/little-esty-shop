# [Little Esty Shop](https://fathomless-stream-92676.herokuapp.com/)
<div id="top"></div>

<!-- ABOUT THE PROJECT -->
## About The Project

This repo was written as part of the Turing School of Software Design's group project requirements for Mod 2. We were tasked with building new features to a mock e-commerce website in accordance to a series of 40 user stories. The stories built functionality where merchants and admins can manage inventory and fulfill customer invoices. The project was designed to demonstrate a number of learning objectives, including:

* Practice designing a normalized database schema and defining model relationships.
* Utilize advanced routing techniques including namespacing to organize and group like functionality together.
* Utilize advanced active record techniques to perform complex database queries.
* Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code.

Additionally, each of us were individually tasked with adding a feature to our website for the solo project evaluation requirement. This feature was to add functionality for merchants to create bulk discounts for their items. A “bulk discount” is a discount based on the quantity of items the customer is buying, for example “20% off orders of 10 or more items”. The learning goals for this portion included: 

* Write migrations to create tables and relationships between tables
* Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
* Write model tests that fully cover the data logic of the application
* Write feature tests that fully cover the functionality of the application

<p align="right">(<a href="#top">back to top</a>)</p>

## Requirements

- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

This project requires Ruby 2.7.4.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

<!-- USAGE EXAMPLES -->
## Database Schema

![image](https://user-images.githubusercontent.com/92219945/157352010-663790ce-2566-43ec-b38a-a1f289d0ab53.png)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->
## Evaluation Criteria

<li> <a href="https://github.com/turingschool-examples/little-esty-shop/blob/main/doc/user_stories.md" title="Group Project">Group Project</a> </li>
<li> <a href="https://backend.turing.edu/module2/projects/bulk_discounts" title="Solo Project">Solo Project</a> </li>

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->
## Self Evaluation

Our team was extremely pleased with not only our progress but our process. We had instant chemistry and complementary skills that made giving and receiving feedback fun and informative. By balancing our intellectual curiosity with tracking our progress using GitHub projects, we were able to not only complete all project requirements well before the deadline but refactor each other's work and learn new approaches to similar problems. Ultimately this process of giving and receiving feedback refined our product and strengthened our coding skills as individuals. 

For the individual portion of this assignment, I was extremely pleased with my thorough testing and activerecord. While I believe significant improvements could be made to my view page, it is all functional and uses minimum logic. I plan to expand upon this project to make it more pleasant for a user to visit and to grow my front end skills over the intermission.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

<li> Austin Moore - https://www.linkedin.com/in/austin-c-moore/ - AustinChristianMoore@gmail.com </li>
<li> Paul Leonard - https://www.linkedin.com/in/paul-leonard-30687b221/ - PaulpaulLeonard@gmail.com </li>
<li> Richard LaBreque - https://www.linkedin.com/in/richard-labrecque-687b3221a/ - RichardLaBreque@gmail.com </li>
<li> Sully Birashk - https://www.linkedin.com/in/sully-birashk-a33a15228/ - Sully.Birashk@gmail.com </li>

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png
