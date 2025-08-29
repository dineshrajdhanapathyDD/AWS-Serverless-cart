# AWS Serverless Shopping Cart

A serverless e-commerce shopping cart application built with AWS services, featuring a Vue.js frontend and Python Lambda backend.

## Architecture

This application uses a serverless architecture with the following AWS services:
- **AWS Lambda** - Backend API functions
- **Amazon DynamoDB** - Shopping cart data storage
- **Amazon Cognito** - User authentication
- **Amazon API Gateway** - REST API endpoints
- **Amazon SQS** - Asynchronous cart deletion processing
- **AWS Amplify** - Frontend hosting and CI/CD

## Project Structure

```
├── backend/                    # Serverless backend services
│   ├── shopping-cart-service/  # Cart management Lambda functions
│   ├── product-mock-service/   # Mock product catalog service
│   ├── layers/                 # Shared Lambda layers
│   └── *.yaml                  # SAM templates
├── frontend/                   # Vue.js web application
│   ├── src/                    # Vue.js source code
│   ├── public/                 # Static assets
│   └── package.json            # Frontend dependencies
├── amplify-ci/                 # Amplify deployment template
└── amplify.yml                 # Amplify build configuration
```

## Features

- **User Authentication** - Cognito-based user registration and login
- **Product Catalog** - Browse available products
- **Shopping Cart** - Add, update, remove items from cart
- **Cart Migration** - Transfer anonymous cart to authenticated user
- **Checkout Process** - Complete purchase workflow
- **Real-time Updates** - DynamoDB streams for cart synchronization

## Prerequisites

- AWS CLI configured with appropriate permissions
- SAM CLI installed
- Node.js and Yarn
- Python 3.8+

## Local Development

### Backend Setup

1. Navigate to backend directory:
```bash
cd backend
```

2. Deploy authentication service:
```bash
TEMPLATE=auth S3_BUCKET=your-bucket make deploy
```

3. Deploy product mock service:
```bash
TEMPLATE=product-mock S3_BUCKET=your-bucket make deploy
```

4. Deploy shopping cart service:
```bash
TEMPLATE=shoppingcart-service S3_BUCKET=your-bucket make deploy
```

### Frontend Setup

1. Navigate to frontend directory:
```bash
cd frontend
```

2. Install dependencies and start development server:
```bash
make serve
```

## Deployment

### Using AWS Amplify

1. Deploy the Amplify infrastructure:
```bash
aws cloudformation deploy \
  --template-file amplify-ci/amplify-template.yaml \
  --stack-name amplify-shopping-cart \
  --parameter-overrides \
    Repository=https://github.com/your-repo/AWS-Serverless-Cart \
    OauthToken=your-github-token \
    SrcS3Bucket=your-source-bucket \
  --capabilities CAPABILITY_IAM
```

2. Connect your repository to Amplify Console for automatic deployments

### Manual Deployment

1. Deploy backend services using SAM CLI
2. Build and deploy frontend to S3/CloudFront
3. Update CORS settings with frontend domain

## Environment Variables

### Backend
- `TABLE_NAME` - DynamoDB table name
- `ALLOWED_ORIGIN` - Frontend domain for CORS
- `PRODUCT_SERVICE_URL` - Product service API endpoint
- `USERPOOL_ID` - Cognito User Pool ID

### Frontend
- `ORIGIN` - Application domain
- `STACKNAME` - CloudFormation stack name

## API Endpoints

### Shopping Cart Service
- `GET /cart` - List cart items
- `POST /cart` - Add item to cart
- `PUT /cart/{product_id}` - Update cart item
- `POST /cart/migrate` - Migrate anonymous cart
- `POST /cart/checkout` - Checkout cart
- `GET /cart/{product_id}/total` - Get cart total

### Product Service
- `GET /product` - List all products
- `GET /product/{product_id}` - Get product details

## Testing

Run backend tests:
```bash
cd backend
make tests
```

## Cleanup

Delete all resources:
```bash
cd backend
TEMPLATE=shoppingcart-service make delete
TEMPLATE=product-mock make delete
TEMPLATE=auth make delete
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.