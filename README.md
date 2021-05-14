<pre>
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::: ARTH TASK 6 : EC2 - S3 - Cloudfront Integration Script ::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                               ________
  #aws                      .-          -.
                           /              \    
                                                                            ####  copyright@ KAUSHAL SONI
      #s3                 |,  .-.    .-.  ,|    
                          | )( _/    \_ )( |
                          |/      /\      \|          $Cloudfront
           (@_            <__     ^^     __> 
   _        ) \____________\__ |IIIIII| __/_________________________________________
  ( )@8@8@8@{}<______________________________________________________________________>
            )_/              \  IIIIII  /                                     ::::::
           (@                  --------                                           ::
                                 @@@
=============================================================================================================

_______________________________ __________________________________[ TASK DESCRIPTION ]
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::  $$$ The architecture includes- 
::::     - Webserver configured on EC2 Instance
::::     - Document Root(/var/www/html) made persistent by mounting on EBS Block Device.
::::     - Static objects used in code such as pictures stored in S3
::::     - Setting up Content Delivery Network using CloudFront and using the origin domain as S3 bucket. 
::::     - Finally place the Cloud Front URL on the webapp code for security and low latency.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
___________________________________________________________________________________________________________

This Script will help in doing this task in Just simple steps. So, lets disscuss :
</pre>
