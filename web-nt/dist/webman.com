1��� |��  ~���  \ͫ�<�D(�A�U�P���E�  ͵��ͫ�<�A8�Q8͵�2;�@2����(\��> �� _�ͫ:�͕�ͫ�n:~��!��J~<(�	ͫ:�͕*	́ �:�2�> �� ��(�ͫ�<� ��O���(���>�� �6�>�� ��O���<�Q��M(&�S(͵��O>�� ���>�� ����^
ͫ�n:~�(���0ꇇ��!��"�p
ͫ�n:~6 #<�8�:~� ;	́ > 2�A!�6��
́ �����
́ �����
́ �����
́ �����
́� 6���*	́��*��! ����\	ͫ!� �	ͫy�8�������#��	ͫ��~�� 0>.͊#����N�6���f�6���V�6���^�6��>���6���xë� �a��{��_�6 ��� ��08�
8��0�o��6��
}� !~~#�6 �ͫ�<�Y���_� ����͞���
8��0Ê��	� ���>͊> ͊>Ê>	Ê>͊>
Ê�� <��2�!� ���2�"� ���� <�� �o�$�! ~� (� (#�0�
0Wy�8�8�8O�y���"���
8	�
�>1͊��0͊��� !�~�w#��	The Web Manager Utility

This program assigns Station Addresses to the Web stations
and Passwords / Privileges for each User area in each station.
This information is stored in encrypted form in the Web system
program SIGN.COM. To modify a system other than the local one,
you must specify the drive containing the system programs. It is
suggested that this utility be kept seperate from the rest of the
software, in a secure place.

  D	Change Drive, Current Drive is A:

  A	Assign Station Address

  P	Examine or modify Passwords / Privileges

  E	Exit this program

Which? $

  You may modify the system program either locally or over the Web
by using Map and this option to change drives. The system program
SIGN.COM for the station that you are changing must be present on
the drive which you specify.

Change System on Drive: $

  Use this option to change Station Address Assignments.

Each Station MUST have a UNIQUE ADDRESS!

CAUTION - Changing address assignments remotely, over the Web,
is NOT recommended.

The new address becomes active when SIGN.COM executes, ie. at
the cold start of the Web, or at sign-off.

THE CURRENT STATION ADDRESS IS $
Change Address to: $
New Address will be: $  OK?  (Y or N) $
De-activate this user number? $			Change	 Change	 Remote	 Remote
User #	   Password	 User	 Attrib	  Read	 Write	Manager
===============================================================
$  $
  M -	Modify Password & Privileges
  S -	Save changes
  Q -	Quit, abandon changes
Which?  $
Select User #: $
Password (up to 15 chars): $
Privileges:  (Y or N)
Change User Area? $
Set File Attributes? $
Remote Disk Read? $
Remote Disk Write? $
Manager Status? $
Cannot find file SIGN.COM on disk.
Hit RETURN to continue. $
Disk Error.   Hit return to continue. $   Y$                SIGN    COM                                                                                                                                                                                                                                                                                                                                                                     