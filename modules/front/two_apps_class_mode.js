const BASE_URL = "http://localhost:3000/cities.json"
const POST_BASE_URL = "http://localhost:3000/cities/"
const TEMP_URL = "http://localhost:3000/cities/temps/diff.json"
const NEW_CITY_URL = "http://localhost:3000/cities/create"


document.addEventListener("DOMContentLoaded", function (event) {
    DOMWorker.buildDOM();
    FetchData.fetchCityData();
    FetchData.timeIntervalCallback();
    DOMWorker.about(); 
    setTimeout(FetchData.postData, 6000)
    document.addEventListener("click", function (e) {
        e.preventDefault()
        //add fetching notice
        e.target.matches("#green") ? FetchData.postData() : null
        e.target.matches("#pickCity") ? DOMWorker.pickCity() : null
        e.target.matches("#button2") ? FetchData.fetchTempDiff() : null
        e.target.matches("#aboutButton") ? DOMWorker.about() : null
        e.target.matches("#pause") ? FetchData.timeIntervalCallback() : null
        e.target.matches("#addButton") ? FetchData.searchForCity() : null
    });
});


class DOMWorker {

    constructor() {

    }


    static about() {

        
        if (document.getElementById("fetched")) {
            main.removeChild(document.getElementById("fetched"));
        }
        const about = document.getElementById("fetched") || document.createElement("div");
        about.setAttribute("id", "fetched")
        const h2 = document.createElement("h2")
        h2.innerText = "ABOUT:"
        const p = document.createElement("p");
        const p2 = document.createElement("p");
        const p3 = document.createElement("p");
        const p4 = document.createElement("p");
        const p5 = document.createElement("p");
        const p6 = document.createElement("p");
        const p0 = document.createElement("p");
        p.innerText = "Boiling Forest is brought to you from the mind of a conscientious citizen."
        p2.innerText = "Randall Taylor graduated from the University of Arizona with  BS in Physiology, minor in Biochemistry,"
        p3.innerText = "and second minor in business administration. With a strong interest in science he always had a full "
        p4.innerText = "mind of scientific and engineering ideas."
        const abstract = document.createElement("h2");
        abstract.innerText = "ABSTRACT:"
        const p7 = document.createElement("p");
        p7.innerText = "Global warming is largely considered fact in the scientific community.The pumping of CO2 into the air by way of capitalistic"
        const p8 = document.createElement("p")
        p8.innerText = "societies has given rise to a blanket of gas.This gas traps radiation from the sun and holds that energy in longer. The goal is to show"
        const p9 = document.createElement("p")
        p9.innerText = "that the earth takes longer to cool after the sun has set each night over months and years."
        const p10 = document.createElement("p")
        p10.innerText = "This application aims to track this temperature change to ascertain if and to what degree this is happening."
        const p11 = document.createElement("p");
        p0.innerText = "APPLICATION IS SCHEDULED TO GET DATA EVERY 6 HOURS AND SAVE THEAT DATA"
        about.appendChild(h2);
        about.appendChild(p0);
        about.appendChild(p);
        about.appendChild(p2);
        about.appendChild(p3);
        about.appendChild(p4);
        about.appendChild(p5);
        about.appendChild(p6);
        about.appendChild(abstract)
        about.appendChild(p7);
        about.appendChild(p8);
        about.appendChild(p9);
        about.appendChild(p10);
        about.appendChild(p11);
        main.appendChild(about);
    }
    static buildDOM() {
        console.log("buildDOM is running")
        const main = document.getElementById("main");
        const newDiv = document.getElementById("fetched") || document.createElement("div");
        newDiv.setAttribute("id", "fetched");
        const button = document.createElement("button");
        const aboutButton = document.createElement("button");
        aboutButton.innerText = "About";
        aboutButton.setAttribute("id", "aboutButton");
        button.setAttribute("id", "green");
        button.setAttribute("class", "button")
        button.innerText = "Display Current Temps"
        const button2 = document.createElement("button");
        const buttonPause = document.createElement("button");
        const addCityButton = document.createElement("button");
        addCityButton.setAttribute("id", "pickCity");
        addCityButton.innerText = "Add a City to Track"
        buttonPause.setAttribute("id", "pause");
        buttonPause.innerText = "start >>";
        button2.innerText = "Display Temp Decrease Rate ";
        button2.setAttribute("id", "button2");
        button2.setAttribute("class", "button")
        main.appendChild(aboutButton);
        main.appendChild(button);
        main.appendChild(button2);
        main.appendChild(addCityButton);
        main.appendChild(buttonPause);
        main.appendChild(newDiv);
    }
    static putInDom() {

        if (document.getElementById("fetched")) {
            main.removeChild(document.getElementById("fetched"))
        }
        const div = document.getElementById("fetched") || document.createElement("div");
        div.setAttribute("id", "fetched")

        const newDiv = document.getElementById("fetched")

        FetchData.Superresponse.map(obj => {


            const subDiv = document.getElementById(obj.city) || document.createElement("div");

            subDiv.setAttribute("id", obj.fetchURL.slice(42, 65));
            subDiv.setAttribute("class", "white")


            const newH = document.getElementById(obj.city + obj.city) || document.createElement("h2");
            newH.setAttribute("id", obj.city + obj.fetchURL);
            const newerH = document.getElementById(obj.temp_high) || document.createElement("h2");
            newerH.setAttribute("id", `${obj.temp_high}`);
            const lowestH = document.getElementById(obj.temp_low) || document.createElement("h2");
            lowestH.setAttribute("id", `${obj.temp_low}`);
            newerH.innerText = obj.temp_high
            lowestH.innerText = obj.temp_low;

            let cityName = obj.fetchURL.match(/=\w+\W\w+,|=\w+,/)

            newH.innerText = cityName[0].slice(1, cityName[0].length - 1);
            subDiv.appendChild(newH);
            const hiLabel = document.createElement("h3");
            hiLabel.innerText = "Daily High Temp";
            subDiv.appendChild(hiLabel);
            subDiv.appendChild(newerH);
            const label = document.createElement("h3")
            label.innerText = "Daily Low Temp"
            subDiv.appendChild(label);
            subDiv.appendChild(lowestH);
            div.appendChild(subDiv);
        })

        main.appendChild(div);
    }
    static putInDomminos(arg) { 
        
        let sorted = arg.sort((a, b) => function (a, b) {
                if (a["city"].name < b["city"].name) { 
                     return -1
                } else if (a["city"].name == a["city"].name){
                      return  0
                } else {
                    return 1
                } })

        if (document.getElementById("fetched")) {
            main.removeChild(document.getElementById("fetched"))
        }
        const fetched = document.getElementById("fetched") || document.createElement("div");
        fetched.setAttribute("id", "fetched");
        arg.forEach((globalWarming) => {
            const subDiv = document.getElementById(`${globalWarming["city"].name + globalWarming["city"].id}`) || document.createElement("div");
            subDiv.setAttribute("class", "white")
            subDiv.setAttribute("id", `${globalWarming["city"].name + globalWarming["city"].id}`);


            const h2 = document.getElementById(`${globalWarming["city"].id + globalWarming["city"].name}`) || document.createElement("h2");

            h2.setAttribute("id", globalWarming["city"].id + globalWarming["city"].name);
            h2.innerText = globalWarming["city"].name;

            if (document.getElementById(`${globalWarming["info"].slope}`)) {
                let x = document.getElementById(`${globalWarming["info"].slope}`)

                y = x.parentElement
                y.removeChild(x);
            }
            if (document.getElementById(`${globalWarming["info"].slope[1] + globalWarming["info"].slope}`)) {
                let ele = document.getElementById(`${globalWarming["info"].slope[1] + globalWarming["info"].slope}`);
                let parentEle = ele.parentElement;
                parentEle.removeChild(ele);
            }

            const h3 = document.getElementById(`${globalWarming["city"].id}`) || document.createElement("h3")

            h3.setAttribute("id", globalWarming["city"].id)
            h3.innerText = "Slope (rate degrees/hr)";

            const h42 = document.getElementById(`${globalWarming["city"].name + globalWarming["city"].id + globalWarming["city"].id}`) || document.createElement("h4");
            h42.setAttribute("id", globalWarming["city"].name + globalWarming["city"].id + globalWarming["city"].id)
            h42.innerText = globalWarming["info"]["slope"]

            subDiv.appendChild(h2);
            subDiv.appendChild(h3);
            subDiv.appendChild(h42);

            fetched.appendChild(subDiv)
            main.appendChild(fetched);
        })

    }
    static pickCity(){
        if (document.getElementById("fetched")) {
            const main = document.getElementById("main")
            const fetched = document.getElementById("fetched")
            main.removeChild(fetched);
        }
        const main = document.getElementById("main");
        const form = document.getElementById("form") || document.createElement("form");
        form.setAttribute("method", "POST");
        form.setAttribute("action", POST_BASE_URL);
        form.setAttribute("id", "cityForm")
        const label = document.getElementById("label") || document.createElement("label");
        label.setAttribute("id", "label")
        label.innerText = "City"
        const input = document.getElementById("input") || document.createElement("input");
        input.setAttribute("id", "input")
        const send = document.getElementById("addButton") || document.createElement("button");
        send.setAttribute("id", "addButton")
        send.innerText = "add";
        send.setAttribute("type", "submit");
        send.setAttribute("value", "submit");
        send.setAttribute("from", "cityForm");
        form.appendChild(label)
        form.appendChild(input)
        form.appendChild(send)
        main.appendChild(form)

    }

}


