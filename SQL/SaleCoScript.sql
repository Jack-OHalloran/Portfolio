USE [master]
GO

CREATE DATABASE [SaleCo]
GO


USE [SaleCo]
GO


CREATE TABLE [dbo].[ACCT_TRANSACTION](
	[ACCT_TRANS_NUM] [int] NOT NULL,
	[ACCT_TRANS_DATE] [datetime] NULL,
	[CUST_NUMBER] [int] NULL,
	[ACCT_TRANS_TYPE] [nvarchar](8) NULL,
	[ACCT_TRANS_AMOUNT] [real] NULL,
 CONSTRAINT [PK_ACCT_TRANSACTION] PRIMARY KEY CLUSTERED 
(
	[ACCT_TRANS_NUM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[CUSTOMER](
	[CUST_NUMBER] [int] NOT NULL,
	[CUST_LNAME] [nvarchar](15) NULL,
	[CUST_FNAME] [nvarchar](15) NULL,
	[CUST_INITIAL] [nvarchar](1) NULL,
	[CUST_AREACODE] [nvarchar](3) NULL,
	[CUST_PHONE] [nvarchar](8) NULL,
	[CUST_BALANCE] [real] NULL,
 CONSTRAINT [PK_CUSTOMER] PRIMARY KEY CLUSTERED 
(
	[CUST_NUMBER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[INVOICE](
	[INV_NUMBER] [int] NOT NULL,
	[CUST_NUMBER] [int] NULL,
	[INV_DATE] [datetime] NULL,
	[INV_SUBTOTAL] [real] NULL,
	[INV_TAX] [real] NULL,
	[INV_TOTAL] [real] NULL,
	[INV_PAY_TYPE] [nvarchar](5) NULL,
	[INV_PAY_AMOUNT] [real] NULL,
	[INV_BALANCE] [real] NULL,
 CONSTRAINT [PK_INVOICE] PRIMARY KEY CLUSTERED 
(
	[INV_NUMBER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[LINE](
	[INV_NUMBER] [int] NOT NULL,
	[LINE_NUMBER] [smallint] NOT NULL,
	[PROD_CODE] [nvarchar](10) NULL,
	[LINE_UNITS] [real] NULL,
	[LINE_PRICE] [real] NULL,
	[LINE_AMOUNT] [real] NULL,
 CONSTRAINT [PK_LINE] PRIMARY KEY CLUSTERED 
(
	[INV_NUMBER] ASC,
	[LINE_NUMBER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[PRODUCT](
	[PROD_CODE] [nvarchar](10) NOT NULL,
	[PROD_DESCRIPT] [nvarchar](35) NULL,
	[PROD_INDATE] [datetime] NULL,
	[PROD_QOH] [smallint] NULL,
	[PROD_MIN] [smallint] NULL,
	[PROD_PRICE] [real] NULL,
	[PROD_DISCOUNT] [float] NULL,
	[VEND_NUMBER] [int] NULL,
 CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED 
(
	[PROD_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[VENDOR](
	[VEND_NUMBER] [int] NOT NULL,
	[VEND_NAME] [nvarchar](15) NULL,
	[VEND_CONTACT] [nvarchar](50) NULL,
	[VEND_AREACODE] [nvarchar](3) NULL,
	[VEND_PHONE] [nvarchar](8) NULL,
	[VEND_STATE] [nvarchar](2) NULL,
	[VEND_ORDER] [nvarchar](1) NULL,
 CONSTRAINT [PK_VENDOR] PRIMARY KEY CLUSTERED 
(
	[VEND_NUMBER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ACCT_TRANSACTION]  WITH CHECK ADD  CONSTRAINT [fk_ACCT_TRANSACTION_CUSTOMER_CUST_NUMBER] FOREIGN KEY([CUST_NUMBER])
REFERENCES [dbo].[CUSTOMER] ([CUST_NUMBER])
GO

ALTER TABLE [dbo].[ACCT_TRANSACTION] CHECK CONSTRAINT [fk_ACCT_TRANSACTION_CUSTOMER_CUST_NUMBER]
GO


ALTER TABLE [dbo].[INVOICE]  WITH CHECK ADD  CONSTRAINT [fk_INVOICE_CUSTOMER_CUST_NUMBER] FOREIGN KEY([CUST_NUMBER])
REFERENCES [dbo].[CUSTOMER] ([CUST_NUMBER])
GO

ALTER TABLE [dbo].[INVOICE] CHECK CONSTRAINT [fk_INVOICE_CUSTOMER_CUST_NUMBER]
GO



ALTER TABLE [dbo].[LINE]  WITH CHECK ADD  CONSTRAINT [fk_LINE_PRODUCT_PROD_CODE] FOREIGN KEY([PROD_CODE])
REFERENCES [dbo].[PRODUCT] ([PROD_CODE])
GO

ALTER TABLE [dbo].[LINE] CHECK CONSTRAINT [fk_LINE_PRODUCT_PROD_CODE]
GO


ALTER TABLE [dbo].[PRODUCT]  WITH CHECK ADD  CONSTRAINT [fk_PRODUCT_VENDOR_VEND_NUMBER] FOREIGN KEY([VEND_NUMBER])
REFERENCES [dbo].[VENDOR] ([VEND_NUMBER])
GO

ALTER TABLE [dbo].[PRODUCT] CHECK CONSTRAINT [fk_PRODUCT_VENDOR_VEND_NUMBER]
GO



CREATE VIEW [dbo].[qryCustomer-Invoice-Transactions-Grouped-by-Customer]
AS
SELECT        dbo.CUSTOMER.CUST_NUMBER, dbo.CUSTOMER.CUST_LNAME, dbo.INVOICE.INV_NUMBER, dbo.INVOICE.INV_DATE, dbo.INVOICE.INV_TOTAL, dbo.INVOICE.INV_PAY_AMOUNT, dbo.INVOICE.INV_PAY_TYPE, 
                         dbo.INVOICE.INV_BALANCE
FROM            dbo.CUSTOMER INNER JOIN
                         dbo.INVOICE ON dbo.CUSTOMER.CUST_NUMBER = dbo.INVOICE.CUST_NUMBER
GO


CREATE VIEW [dbo].[qryList-all-Purchases-and-Group-by-Customer]
AS
SELECT        dbo.CUSTOMER.CUST_NUMBER, dbo.CUSTOMER.CUST_LNAME, dbo.INVOICE.INV_NUMBER, dbo.LINE.LINE_NUMBER, dbo.PRODUCT.PROD_CODE, dbo.LINE.LINE_UNITS, dbo.PRODUCT.PROD_DESCRIPT
FROM            dbo.CUSTOMER INNER JOIN
                         dbo.INVOICE ON dbo.CUSTOMER.CUST_NUMBER = dbo.INVOICE.CUST_NUMBER INNER JOIN
                         dbo.LINE ON dbo.INVOICE.INV_NUMBER = dbo.LINE.INV_NUMBER INNER JOIN
                         dbo.PRODUCT ON dbo.LINE.PROD_CODE = dbo.PRODUCT.PROD_CODE
GO




