
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

# Multi-planet Space Mission Design Tools


A collection of MATLAB scripts created in 2019/20 as part of my final year dissertation project whilst studying for an intergrated masters degree in aerospace engineering at the University of Nottingham, UK. 

The minimisation of fuel requirements for an interplanetary space mission can have significant impact on mission feasibility. This project aims to provide academia and early phase mission designers a set of software tools that can be used in assessing the feasibility of potential trajectory concepts. Implementation will be through MATLAB, with the main parameter of focus being ΔV – the maximum change in velocity of a rocket. Through programming, a kinematic model, taking advantage of the patched conic approximation to simply trajectory calculation, is developed. 

ΔV required for interplanetary missions is computed as a function of time and an enumerative approach is taken to determine optimal times of departure and arrival at respective bodies. The required ΔV to patch together incoming and outgoing trajectories, during a gravity-assist flyby, is also programmed as a function of time. These software tools are then verified against test cases involving real mission data, such as NASA’s recent mission to Mars and Voyager 2’s flyby of Jupiter. 

Results showed that the software tools created provide sufficient accuracy to determine trajectory concepts and assess their feasibility as per the project objectives. These trajectories can then be passed on to more sophisticated, dynamic, multibody simulations with higher accuracy.







## Built With

* [MATLAB](https://www.mathworks.com/products/matlab.html)


  

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Twitter - [@TraderTDF](https://twitter.com/TraderTDF)

LinkedIn - [https://www.linkedin.com/in/RAMWatson/](https://www.linkedin.com/in/RAMWatson/)

Project Link: [https://github.com/Elisik/Multi-Planet-Space-Mission-Design-Tools](https://github.com/Elisik/Multi-Planet-Space-Mission-Design-Tools)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/RAMWatson/

