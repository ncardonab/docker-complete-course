# Data and volumes

| Application<br>(Code + Environment)           | Temporary App Data<br>(e.g. entered user input) | Permament App Data<br>(e.g. user accounts)                |
| --------------------------------------------- | ----------------------------------------------- | --------------------------------------------------------- |
| Written & provided by you (= the developer)   | Fetched / Produced in running container         | Fetched / Produced in running container                   |
| Added to image and container in build phase   | Stored in memory or temporary files             | Stored in files or a database                             |
| "Fixed": Can't be changed once image is built | Dynamic and changing, but cleared regularly     | Must not be lost if container stops / restarts            |
| Read-only, hence stored in Images             | Read + write, hence stored in Containers        | Read + write, permanent, stored with Containers & Volumes |

- Once you run a container and create data there, it'll last the time the container is not removed, if this gets removed you'll lose all that data, even if you try to run the container again, it would be a new one.
- If you stop the container and then start it again the created data will be there.
