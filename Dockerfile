FROM maven AS buildstage
RUN mkdir /opt/shiva_cicd_project
WORKDIR /opt/shiva_cicd_project
COPY . .
RUN mvn clean install    ## artifact -- .war 

## tomcat deploy stage 
FROM tomcat 
WORKDIR webapps 
COPY --from=buildstage /opt/shiva_cicd_project/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
